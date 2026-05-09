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
  console.log(chalk.cyan.bold('┌────────────────────────────────────────────┐'));
  console.log(chalk.cyan.bold('│ CardPilot Dev                              │'));
  console.log(chalk.cyan.bold('└────────────────────────────────────────────┘'));
  console.log(chalk.dim('Select services with <space>, then press <enter>.\n'));
}

type Service = 'cardpilot-backend:serve' | 'cardpilot-mobile:run';

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
      name: 'cardpilot-mobile:run',
      value: 'cardpilot-mobile:run',
      message: `${chalk.bold('mobile')}   ${chalk.dim('(cardpilot-mobile:run)')}`,
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

  // If both selected, run them in one Nx invocation so Nx TUI can manage logs.
  const wantBackend = selected.includes('cardpilot-backend:serve');
  const wantMobile = selected.includes('cardpilot-mobile:run');
  if (wantBackend && wantMobile) {
    runNx(['run-many', '-t', 'serve,run', '-p', 'cardpilot-backend,cardpilot-mobile', '--parallel']);
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
