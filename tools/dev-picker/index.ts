import enquirer from 'enquirer';
import chalk from 'chalk';
import { spawn } from 'node:child_process';
import path from 'node:path';

const { MultiSelect } = enquirer as unknown as {
  MultiSelect: new (opts: any) => { run: () => Promise<string[]> };
};

function nxBin(): string {
  return path.join(process.cwd(), 'node_modules', '.bin', 'nx');
}

function printBanner() {
  // ASCII-only banner for consistent terminal rendering.
  console.log(
    chalk.cyan.bold('┌────────────────────────────────────────────┐'),
  );
  console.log(
    chalk.cyan.bold('│ CardPilot Dev                              │'),
  );
  console.log(
    chalk.cyan.bold('└────────────────────────────────────────────┘'),
  );
  console.log(chalk.dim('Select services with <space>, then press <enter>.\n'));
}

type Service =
  | 'cardpilot-backend:serve'
  | 'cardpilot-ocr-service:serve'
  | 'cardpilot-app:run'
  | 'cardpilot-widgetbook:run';

const projectByService: Record<Service, string> = {
  'cardpilot-backend:serve': 'cardpilot-backend',
  'cardpilot-ocr-service:serve': 'cardpilot-ocr-service',
  'cardpilot-app:run': 'cardpilot-app',
  'cardpilot-widgetbook:run': 'cardpilot-widgetbook',
};

function runNx(args: string[]) {
  const child = spawn(nxBin(), args, {
    stdio: 'inherit',
    env: {
      ...process.env,
      // Force-enable Nx's built-in Terminal UI.
      NX_TUI: 'true',
    },
  });
  child.on('exit', (code) => process.exit(code ?? 0));
}

async function main() {
  printBanner();

  const choices: { name: Service; message: string; value: Service }[] = [
    {
      name: 'cardpilot-backend:serve',
      value: 'cardpilot-backend:serve',
      message: `${chalk.bold('backend')}  ${chalk.dim('(cardpilot-backend:serve)')}`,
    },
    {
      name: 'cardpilot-ocr-service:serve',
      value: 'cardpilot-ocr-service:serve',
      message: `${chalk.bold('ocr')}      ${chalk.dim('(cardpilot-ocr-service:serve)')}`,
    },
    {
      name: 'cardpilot-app:run',
      value: 'cardpilot-app:run',
      message: `${chalk.bold('mobile')}   ${chalk.dim('(cardpilot-app:run)')}`,
    },
    {
      name: 'cardpilot-widgetbook:run',
      value: 'cardpilot-widgetbook:run',
      message: `${chalk.bold('widgetbook')} ${chalk.dim('(cardpilot-widgetbook:run)')}`,
    },
  ];

  let selected: Service[] = [];
  try {
    selected = (await new MultiSelect({
      name: 'services',
      message: 'Choose service(s) to run',
      choices,
    }).run()) as Service[];
  } catch {
    process.exit(0);
  }

  if (selected.length === 0) process.exit(0);

  // Run multiple selections in one Nx invocation so the TUI manages all logs.
  if (selected.length > 1) {
    const projects = selected.map((service) => projectByService[service]);
    runNx([
      'run-many',
      '-t',
      'serve,run',
      '-p',
      projects.join(','),
      '--parallel',
    ]);
    return;
  }

  // Otherwise run the single selected service.
  runNx(['run', selected[0]]);
}

main().catch((err) => {
  // eslint-disable-next-line no-console
  console.error(err?.stack ?? String(err));
  process.exit(1);
});
