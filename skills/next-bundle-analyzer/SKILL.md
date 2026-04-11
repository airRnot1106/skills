---
name: next-bundle-analyzer
description: >
  Analyze and quality-check Next.js (16+, Turbopack) bundle sizes using
  `next experimental-analyze --output`. Use when the user wants to: inspect
  bundle sizes, find large dependencies, detect duplicate modules,
  quality-check production builds, or get optimization recommendations.
  Triggers on requests like "analyze the bundle", "check bundle size",
  "find large packages", "bundle quality check", "バンドル分析",
  "バンドルサイズ確認", or when the user mentions `next experimental-analyze`.
---

# Next.js Bundle Analyzer

Analyze Turbopack bundle output from `next experimental-analyze --output`.

## Workflow

### Step 1: Generate analyze output

Run the command using the appropriate package manager for the project:

```bash
# npm
npx next experimental-analyze --output

# pnpm
pnpm next experimental-analyze --output

# yarn
yarn next experimental-analyze --output

# bun
bunx next experimental-analyze --output
```

Output is written to `.next/diagnostics/analyze/`.

> If the project has an `analyze` script in `package.json`, use that instead.

### Step 2: Run the analysis script

```bash
uv run <skill-dir>/scripts/analyze_bundle.py .next/diagnostics/analyze
```

Replace `<skill-dir>` with the path to this skill's directory.

### Step 3: Interpret results

The script outputs:

| Section                | What to look for                                             |
| ---------------------- | ------------------------------------------------------------ |
| **Total bundle size**  | Compressed size matters for network; raw size for parse time |
| **Top output files**   | Files >100KB (raw) are candidates for investigation          |
| **Top npm packages**   | User-land packages unexpectedly large (not `next`/`react`)   |
| **Duplicate packages** | Same package at multiple versions = wasted bytes             |
| **Recommendations**    | Auto-detected optimization opportunities                     |

### Step 4: Apply optimizations

Based on results, common fixes (ref: `node_modules/next/dist/docs/01-app/02-guides/package-bundling.md`):

**Large packages with many exports** → Add to `optimizePackageImports`:

```ts
// next.config.ts
experimental: {
  optimizePackageImports: ['icon-library', 'utility-library'],
}
```

**Heavy client-side library that could run server-side** → Move logic to a Server Component (e.g. syntax highlighting, markdown parsing, date formatting).

**Duplicate packages** → Run `npm dedupe` / `pnpm dedupe` / `yarn dedupe`.

**Server-only packages leaking into client** → Add to `serverExternalPackages`:

```ts
// next.config.ts
serverExternalPackages: ['package-name'],
```

## Comparing before/after

```bash
# Save current state
cp -r .next/diagnostics/analyze ./analyze-before

# Make changes, then re-analyze
npx next experimental-analyze --output

# Compare
uv run <skill-dir>/scripts/analyze_bundle.py ./analyze-before
uv run <skill-dir>/scripts/analyze_bundle.py .next/diagnostics/analyze
```

## Interactive mode

For visual treemap in the browser (no `--output`):

```bash
npx next experimental-analyze
# Opens http://localhost:4000
```
