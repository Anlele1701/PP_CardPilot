import enquirer from 'enquirer';
import chalk from 'chalk';
import { execFileSync, spawn } from 'node:child_process';
import path from 'node:path';
import blessed from 'blessed';
import contrib = require('blessed-contrib');

type NxProjectJson = {
  name?: string;
  targets?: Record<string, { executor?: string }>;
};

const { MultiSelect } = enquirer as unknown as {
  MultiSelect: new (opts: any) => { run: () => Promise<string[]> };
};

function nxBin(): string {
  return path.join(process.cwd(), 'node_modules', '.bin', 'nx');
}

function runNxJson<T>(args: string[]): T {
  const stdout = execFileSync(nxBin(), [...args, '--json'], {
    encoding: 'utf8',
    stdio: ['ignore', 'pipe', 'pipe'],
  });
  return JSON.parse(stdout) as T;
}

function padRight(input: string, len: number) {
  if (input.length >= len) return input;
  return input + ' '.repeat(len - input.length);
}

function parseMode(argv: string[]) {
  const modeArg = argv.find((a) => a.startsWith('--mode='));
  return modeArg ? modeArg.split('=')[1] || 'default' : 'default';
}

function hasFlag(argv: string[], flag: string) {
  return argv.includes(flag) || argv.some((a) => a === `--${flag}`);
}

type ServiceChoice = {
  name: string; // value
  message: string; // label
  value: string;
};

function buildServiceChoices(
  projects: string[],
  mode: string,
): ServiceChoice[] {
  const choices: ServiceChoice[] = [];

  for (const project of projects) {
    // Hide common non-service projects in dev mode.
    if (mode === 'dev' && (project.endsWith('-e2e') || project.includes('e2e')))
      continue;

    const cfg = runNxJson<NxProjectJson>(['show', 'project', project]);
    const targets = Object.keys(cfg.targets ?? {});

    const wantedTargets = mode === 'dev' ? ['serve', 'run'] : targets; // default mode shows everything runnable via nx run

    for (const t of wantedTargets) {
      if (!targets.includes(t)) continue;
      const executor = cfg.targets?.[t]?.executor
        ? ` (${cfg.targets?.[t]?.executor})`
        : '';
      const value = `${project}:${t}`;
      choices.push({
        name: value,
        value,
        message: `${chalk.bold(project)}:${chalk.green(t)}${chalk.dim(executor)}`,
      });
    }
  }

  // Stable-ish ordering.
  const rank: Record<string, number> = {
    serve: 0,
    run: 1,
    build: 2,
    test: 3,
    lint: 4,
    e2e: 5,
  };
  choices.sort((a, b) => {
    const [pa, ta] = a.value.split(':');
    const [pb, tb] = b.value.split(':');
    const ra = rank[ta] ?? 99;
    const rb = rank[tb] ?? 99;
    if (ra !== rb) return ra - rb;
    if (pa !== pb) return pa.localeCompare(pb);
    return ta.localeCompare(tb);
  });

  return choices;
}

function runServices(services: string[], opts?: { debugKeys?: boolean }) {
  if (services.length === 0) return;

  const screen = blessed.screen({
    smartCSR: true,
    title: 'CardPilot Dev',
  });

  const header = blessed.box({
    top: 0,
    left: 0,
    height: 3,
    width: '100%',
    tags: false,
    style: { fg: 'cyan' },
    content:
      'CardPilot Dev\n' +
      'Pick log view: ↑/↓ then <space>. Quit: q / Ctrl+C. Focus: ← services | → logs',
  });

  const serviceList = blessed.list({
    top: 3,
    left: 0,
    width: 34,
    height: '100%-3',
    label: 'services',
    border: { type: 'line' },
    keys: true,
    mouse: true,
    vi: true,
    style: {
      border: { fg: 'gray' },
      item: { fg: 'white' },
      selected: { fg: 'black', bg: 'cyan' },
    },
    items: services.map((s) => ` ${s} `),
  });

  const log = contrib.log({
    top: 3,
    left: 34,
    width: '100%-34',
    height: '100%-3',
    border: { type: 'line' },
    label: 'logs',
    tags: false,
    mouse: true,
    keys: true,
    vi: true,
    scrollable: true,
    alwaysScroll: true,
    scrollbar: {
      ch: ' ',
      inverse: true,
    },
    scrollback: 5000,
  });

  screen.append(header);
  screen.append(serviceList);
  screen.append(log);

  const buffers = new Map<string, string[]>();
  const MAX_LINES = 5000;

  for (const svc of services) buffers.set(svc, []);

  let activeIndex = 0;
  const setActive = (nextIdx: number) => {
    if (services.length === 0) return;
    activeIndex = (nextIdx + services.length) % services.length;
    const svc = services[activeIndex]!;
    const lines = buffers.get(svc) ?? [];
    log.setLabel(`logs: ${svc}`);
    // Replace content by clearing and re-adding. blessed-contrib log keeps its own buffer.
    log.setContent('');
    for (const l of lines) log.log(l);
    screen.render();
  };

  // bind keys
  screen.key(['C-c'], () => {
    shutdown();
    process.exit(0);
  });
  // Avoid accidental exit / confusing behavior from Escape.
  screen.key(['escape'], () => {
    // no-op
  });
  screen.key(['left'], () => serviceList.focus());
  screen.key(['right'], () => log.focus());
  // space to choose which service => run services
  serviceList.key(['space'], () => {
    const sel = serviceList.selected ?? 0;
    setActive(sel);
  });
  serviceList.key(['enter'], () => {
    const sel = serviceList.selected ?? 0;
    setActive(sel);
  });

  // Log scrolling (when log pane is focused).
  // Note: blessed-contrib log wraps a blessed element with scroll methods.
  log.key(['up'], () => {
    // @ts-expect-error blessed-contrib typing
    log.scroll(-1);
    screen.render();
  });
  log.key(['down'], () => {
    // @ts-expect-error blessed-contrib typing
    log.scroll(1);
    screen.render();
  });
  log.key(['pageup'], () => {
    // @ts-expect-error blessed-contrib typing
    log.scroll(-10);
    screen.render();
  });
  log.key(['pagedown'], () => {
    // @ts-expect-error blessed-contrib typing
    log.scroll(10);
    screen.render();
  });
  log.key(['home', 'g'], () => {
    // @ts-expect-error blessed-contrib typing
    log.setScroll(0);
    screen.render();
  });
  log.key(['end', 'G'], () => {
    // @ts-expect-error blessed-contrib typing
    log.setScroll(log.getScrollHeight?.() ?? 999999);
    screen.render();
  });
  for (let i = 1; i <= 9; i++) {
    screen.key([String(i)], () => {
      if (i - 1 < services.length) setActive(i - 1);
    });
  }

  const children = services.map((svc) => {
    const child = spawn(nxBin(), ['run', svc], {
      stdio: ['ignore', 'pipe', 'pipe'],
    });

    const appendLine = (line: string) => {
      const lines = buffers.get(svc) ?? [];
      lines.push(line);
      if (lines.length > MAX_LINES) lines.splice(0, lines.length - MAX_LINES);
      buffers.set(svc, lines);
      if (services[activeIndex] === svc) {
        log.log(line);
        screen.render();
      }
    };

    const pipe = (stream: NodeJS.ReadableStream, prefix: string) => {
      let buffer = '';
      stream.on('data', (chunk) => {
        buffer += chunk.toString('utf8');
        const lines = buffer.split('\n');
        buffer = lines.pop() ?? '';
        for (const l of lines) {
          if (!l) continue;
          appendLine(prefix + l);
        }
      });
      stream.on('end', () => {
        if (buffer.trim().length) appendLine(prefix + buffer);
      });
    };

    pipe(child.stdout!, '');
    pipe(child.stderr!, '[stderr] ');

    child.on('exit', (code) => {
      appendLine(
        code === 0
          ? chalk.green('exited 0')
          : chalk.red(`exited ${code ?? 'unknown'}`),
      );
    });

    return child;
  });

  function shutdown() {
    for (const c of children) {
      try {
        c.kill('SIGINT');
      } catch {
        // ignore
      }
    }
  }

  process.once('exit', shutdown);
  process.once('SIGTERM', () => {
    shutdown();
  });
  process.once('uncaughtException', (err) => {
    const msg = err instanceof Error ? (err.stack ?? err.message) : String(err);
    log.log(chalk.red('[tui] uncaughtException'));
    for (const line of msg.split('\n')) log.log(chalk.red(line));
    log.log(chalk.yellow('[tui] Press q to quit.'));
    screen.render();
  });
  process.once('unhandledRejection', (err) => {
    const msg = err instanceof Error ? (err.stack ?? err.message) : String(err);
    log.log(chalk.red('[tui] unhandledRejection'));
    for (const line of msg.split('\n')) log.log(chalk.red(line));
    log.log(chalk.yellow('[tui] Press q to quit.'));
    screen.render();
  });

  if (opts?.debugKeys) {
    screen.on('keypress', (_ch: any, key: any) => {
      const name = key?.full ?? key?.name ?? String(key);
      log.log(chalk.dim(`[key] ${name}`));
      screen.render();
    });
  }

  setActive(0);
  serviceList.select(0);
  serviceList.focus();
  screen.render();
}

async function main() {
  const argv = process.argv.slice(2);
  const mode = parseMode(argv);
  const debugKeys = hasFlag(argv, '--debug-keys');

  const projects = runNxJson<string[]>(['show', 'projects']);
  const choices = buildServiceChoices(projects, mode);
  if (choices.length === 0) {
    console.error('No runnable services found.');
    process.exit(1);
  }

  let selected: string[] = [];
  try {
    selected = await new MultiSelect({
      name: 'services',
      message:
        mode === 'dev' ? 'Choose service(s) to run' : 'Choose target(s) to run',
      choices,
    }).run();
  } catch (e) {
    process.exit(0);
  }

  runServices(selected, { debugKeys });
}

main().catch((err) => {
  console.error(err?.stack ?? String(err));
  process.exit(1);
});
