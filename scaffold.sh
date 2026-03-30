#!/bin/bash
# XD Dev Setup Kit — Intuit Design Prototype Scaffolding (v2)
# Usage: Clone the template, rename the folder, cd into it, then run ./scaffold.sh
#
# Prerequisites:
#   - Node.js 18+ (check: node --version)
#   - Git authenticated with github.intuit.com (see README)
#   - ~/.npmrc configured with: registry=https://registry.npmjs.intuit.com/

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_NAME="$(basename "$SCRIPT_DIR")"
IDS_TOKEN_BASE="https://uxfabric.intuitcdn.net/components/design-systems/tokens/ddms3.0/prod/24.5.0/css"
IDS_BRANDS="intuit turbotax quickbooks mailchimp creditkarma mint"

echo "=================================================="
echo "  XD Dev Setup Kit — Scaffolding: $PROJECT_NAME"
echo "=================================================="

# -------------------------------------------------------------------
# Step 1: Scaffold Vite + React 18 + TypeScript
# -------------------------------------------------------------------
echo ""
echo "Step 1/7: Creating React + TypeScript project..."

TEMP_DIR="/tmp/xd-scaffold-$$"
rm -rf "$TEMP_DIR"
mkdir -p "$TEMP_DIR"

(cd /tmp && npm create vite@latest "xd-scaffold-$$/app" -- --template react-ts)

# Move Vite files into current directory (skip files we already have)
cp -n "$TEMP_DIR/app/package.json" ./package.json 2>/dev/null || true
cp -n "$TEMP_DIR/app/tsconfig.json" ./tsconfig.json 2>/dev/null || true
cp -n "$TEMP_DIR/app/tsconfig.app.json" ./tsconfig.app.json 2>/dev/null || true
cp -n "$TEMP_DIR/app/tsconfig.node.json" ./tsconfig.node.json 2>/dev/null || true
cp -n "$TEMP_DIR/app/eslint.config.js" ./eslint.config.js 2>/dev/null || true
cp -n "$TEMP_DIR/app/index.html" ./index.html 2>/dev/null || true
cp -rn "$TEMP_DIR/app/src/" ./src/ 2>/dev/null || true
cp -rn "$TEMP_DIR/app/public/" ./public/ 2>/dev/null || true

if [ -f "$TEMP_DIR/app/.gitignore" ]; then
  cp "$TEMP_DIR/app/.gitignore" ./.gitignore
fi

rm -rf "$TEMP_DIR"

echo "  Done."

# -------------------------------------------------------------------
# Step 2: Create project structure
# -------------------------------------------------------------------
echo ""
echo "Step 2/7: Creating project structure..."

mkdir -p docs
mkdir -p src/{components,pages,layouts,hooks,mocks/data,lib,styles}
mkdir -p public

echo "  Done."

# -------------------------------------------------------------------
# Step 3: Downgrade React to 18.2.0 (IDS compatibility)
# -------------------------------------------------------------------
echo ""
echo "Step 3/7: Installing React 18.2.0 (required for IDS compatibility)..."

npm install react@18.2.0 react-dom@18.2.0 @types/react@18.2.48 @types/react-dom@18.2.18 2>/dev/null
echo "  Done."

# -------------------------------------------------------------------
# Step 4: Install IDS packages + PostCSS + Router
# -------------------------------------------------------------------
echo ""
echo "Step 4/7: Installing IDS components and dependencies..."

# Core IDS components that work well with Vite
npm install @ids-ts/button @ids-ts/badge @ids-ts/typography @ids-ts/loader 2>/dev/null

# Routing
npm install react-router-dom 2>/dev/null

# PostCSS plugins (matches IDS build pipeline)
npm install -D postcss-mixins@9.0.4 postcss-nested@6.0.1 postcss-simple-vars@7.0.1 2>/dev/null

echo "  Done."

# -------------------------------------------------------------------
# Step 5: Download IDS design tokens from CDN (all brands)
# -------------------------------------------------------------------
echo ""
echo "Step 5/7: Downloading IDS design tokens for all brands..."

mkdir -p src/styles/tokens
for brand in $IDS_BRANDS; do
  curl -s "$IDS_TOKEN_BASE/$brand.css" > "src/styles/tokens/$brand.css"
  echo "  Downloaded $brand.css ($(wc -l < "src/styles/tokens/$brand.css" | tr -d ' ') lines)"
done

# Default: use intuit tokens as ids-tokens.css
cp src/styles/tokens/intuit.css src/styles/ids-tokens.css
echo "  Default theme: intuit (change in src/main.tsx to use another brand)"

# -------------------------------------------------------------------
# Step 6: Create configuration files
# -------------------------------------------------------------------
echo ""
echo "Step 6/7: Creating configuration files..."

# Vite config with IDS optimizations
cat > vite.config.ts << 'VITEEOF'
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  server: {
    watch: {
      ignored: ['**/ids-web-full/**', '**/int-design-system/**'],
    },
  },
  optimizeDeps: {
    include: [
      'react',
      'react/jsx-runtime',
      'react/jsx-dev-runtime',
      'react-dom',
      'react-dom/client',
      'react-router-dom',
      '@ids-ts/button',
      '@ids-ts/typography',
      '@ids-ts/badge',
      '@ids-ts/loader',
    ],
  },
})
VITEEOF

# PostCSS config (matches IDS pipeline)
cat > postcss.config.js << 'POSTCSSEOF'
// PostCSS config matching IDS Web component build pipeline
export default {
  plugins: {
    'postcss-mixins': {},
    'postcss-nested': {},
    'postcss-simple-vars': {},
  },
};
POSTCSSEOF

# IDS component CSS imports
cat > src/styles/ids-imports.css << 'IDSEOF'
/* IDS Component CSS — only components whose CSS is compatible with Vite */
@import '@ids-ts/button/dist/main.css';
@import '@ids-ts/typography/dist/main.css';
@import '@ids-ts/badge/dist/main.css';
IDSEOF

# IDS overrides for admin/dashboard UIs
cat > src/styles/ids-overrides.css << 'OVEREOF'
/* IDS Token Overrides for Admin/Dashboard Prototypes
   CDN tokens are designed for full Intuit product pages.
   These overrides provide appropriate scale for internal tools. */

:root, [data-theme="intuit"] {
  /* Softer elevation shadows */
  --color-shadow: rgba(0, 0, 0, 0.06);
  --elevation-level-0: none;
  --elevation-level-1: 0 1px 3px rgba(0, 0, 0, 0.04), 0 1px 2px rgba(0, 0, 0, 0.03);
  --elevation-level-2: 0 2px 8px rgba(0, 0, 0, 0.06), 0 1px 3px rgba(0, 0, 0, 0.04);
  --elevation-level-3: 0 4px 16px rgba(0, 0, 0, 0.08), 0 2px 6px rgba(0, 0, 0, 0.04);

  /* Softer border colors */
  --color-container-border-secondary: #E3E5E8;
  --color-container-border-tertiary: #ECEEF0;
  --color-divider-primary: #E3E5E8;
  --color-divider-secondary: #F0F2F4;
  --color-divider-tertiary: #ECEEF0;
}
OVEREOF

# Global styles
cat > src/styles/global.css << 'STYLEEOF'
/* Global styles — IDS tokens loaded from ids-tokens.css */

*,
*::before,
*::after {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

html {
  font-size: 16px;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

body {
  font-family: var(--font-family-component, -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif);
  font-size: var(--font-size-body-2, 0.875rem);
  line-height: var(--line-height-body, 1.5);
  color: var(--color-text-primary, #393A3D);
  background: var(--color-container-background-primary, #fff);
}

/* Accessibility: respect motion preferences */
@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration: 0.01ms !important;
    transition-duration: 0.01ms !important;
  }
}

/* Skip to content link (a11y) */
.skip-to-content {
  position: absolute;
  top: -100%;
  left: 16px;
  z-index: 1000;
  padding: 8px 16px;
  background: var(--color-action-standard, #0077C5);
  color: var(--color-text-inverse, #fff);
  border-radius: var(--radius-small, 4px);
  text-decoration: none;
  font-weight: 600;
}

.skip-to-content:focus {
  top: 16px;
}

/* Focus styles */
:focus-visible {
  outline: 2px solid var(--color-focus-indicator, #0077C5);
  outline-offset: 2px;
}
STYLEEOF

# App.tsx with IDS theme wrapper
cat > src/App.tsx << 'APPEOF'
import './styles/global.css';

function App() {
  return (
    <div data-theme="intuit" data-colorscheme="light">
      <a href="#main-content" className="skip-to-content">
        Skip to content
      </a>
      <main id="main-content">
        <h1>Prototype</h1>
        <p>Read docs/PRD.md and docs/design.md to get started.</p>
      </main>
    </div>
  );
}

export default App;
APPEOF

# main.tsx with correct CSS import order
cat > src/main.tsx << 'MAINEOF'
import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'

// IDS Design Tokens — default: Intuit theme
// To switch brand, change the import AND the data-theme in App.tsx:
//   import './styles/tokens/turbotax.css'    → data-theme="turbotax"
//   import './styles/tokens/quickbooks.css'  → data-theme="quickbooks"
//   import './styles/tokens/mailchimp.css'   → data-theme="mailchimp"
//   import './styles/tokens/creditkarma.css' → data-theme="creditkarma"
//   import './styles/tokens/mint.css'        → data-theme="mint"
import './styles/ids-tokens.css'

import './styles/ids-overrides.css'
import './styles/ids-imports.css'
import './index.css'
import App from './App.tsx'

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <App />
  </StrictMode>,
)
MAINEOF

# Minimal index.css
cat > src/index.css << 'INDEXEOF'
/* Minimal reset — main tokens are in styles/ids-tokens.css */
#root {
  min-height: 100vh;
}
INDEXEOF

# Gitignore additions
cat >> .gitignore << 'GITEOF'

# IDS design system repos (local reference only)
ids-web-full/
int-design-system/

# Design artifacts (keep in repo)
# docs/

# IDE
.idea/
.vscode/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db
GITEOF

echo "  Done."

# -------------------------------------------------------------------
# Step 7: Set up IDS Storybook MCP Proxy (for component reference)
# -------------------------------------------------------------------
echo ""
echo "Step 7/7: Setting up IDS Storybook MCP proxy..."

MCP_PROXY_DIR="ids-storybook-mcp-proxy"

if [ ! -d "$MCP_PROXY_DIR" ]; then
  mkdir -p "$MCP_PROXY_DIR"

  cat > "$MCP_PROXY_DIR/package.json" << 'MCPPKGEOF'
{
  "name": "ids-storybook-mcp-proxy",
  "version": "1.0.0",
  "type": "module",
  "scripts": { "start": "node server.js" },
  "dependencies": { "@storybook/mcp": "latest" }
}
MCPPKGEOF

  cat > "$MCP_PROXY_DIR/server.js" << 'MCPEOF'
import { createStorybookMcpHandler } from '@storybook/mcp';
import { createServer } from 'node:http';

const BASE = 'https://uxfabric.intuitcdn.net/internal/design-systems/ids-web/main/latest';
const PORT = 6007;

const handler = await createStorybookMcpHandler({
  manifestProvider: async (_req, path) => {
    const url = `${BASE}/${path}`;
    const res = await fetch(url);
    if (!res.ok) throw new Error(`Failed: ${url} ${res.status}`);
    return res.text();
  },
});

const server = createServer(async (req, res) => {
  const url = new URL(req.url, `http://localhost:${PORT}`);
  if (url.pathname === '/health') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ status: 'ok', source: BASE }));
    return;
  }
  if (url.pathname === '/mcp') {
    try {
      const headers = new Headers();
      for (const [k, v] of Object.entries(req.headers)) { if (v) headers.set(k, Array.isArray(v) ? v[0] : v); }
      const body = await new Promise(r => { const c = []; req.on('data', d => c.push(d)); req.on('end', () => r(Buffer.concat(c))); });
      const wr = new Request(`http://localhost:${PORT}${req.url}`, { method: req.method, headers, body: req.method !== 'GET' && req.method !== 'HEAD' ? body : undefined });
      const resp = await handler(wr);
      res.writeHead(resp.status, Object.fromEntries(resp.headers.entries()));
      res.end(await resp.text());
    } catch (e) { res.writeHead(500); res.end(JSON.stringify({ error: e.message })); }
    return;
  }
  res.writeHead(404);
  res.end('Use /mcp or /health');
});

server.listen(PORT, () => {
  console.log(`IDS Storybook MCP ready at http://localhost:${PORT}/mcp`);
  console.log('Connect: claude mcp add ids-storybook --transport http http://localhost:' + PORT + '/mcp');
});
MCPEOF

  (cd "$MCP_PROXY_DIR" && npm install 2>/dev/null)
  echo "  MCP proxy installed to $MCP_PROXY_DIR/"
else
  echo "  MCP proxy already exists at $MCP_PROXY_DIR/"
fi

# Add to gitignore
echo "" >> .gitignore
echo "# IDS Storybook MCP proxy" >> .gitignore
echo "ids-storybook-mcp-proxy/" >> .gitignore

echo "  Done."

# -------------------------------------------------------------------
# Done
# -------------------------------------------------------------------
echo ""
echo "=================================================="
echo "  Setup complete: $PROJECT_NAME"
echo "=================================================="
echo ""
echo "Quick start:"
echo "  npm run dev             Start dev server (http://localhost:5173)"
echo "  npm run build           Production build"
echo "  npm run preview         Preview production build (fast navigation)"
echo ""
echo "Next steps:"
echo "  1. Fill in docs/PRD.md with your product requirements"
echo "  2. Start IDS MCP: cd ids-storybook-mcp-proxy && node server.js"
echo "  3. Connect MCP: claude mcp add ids-storybook --transport http http://localhost:6007/mcp"
echo "  4. Run: npm run dev"
echo "  5. Open Claude Code and say: 'Read the PRD and build the prototype'"
echo ""
echo "IDS components available:"
echo "  import Button from '@ids-ts/button';"
echo "  import Badge from '@ids-ts/badge';"
echo "  import { H4, H5, B2, B3 } from '@ids-ts/typography';"
echo ""
echo "To add more IDS components:"
echo "  npm install @ids-ts/checkbox @ids-ts/radio @ids-ts/switch"
echo ""
echo "IDS Storybook (browse in browser):"
echo "  https://uxfabric.intuitcdn.net/internal/design-systems/ids-web/main/latest/index.html"
echo ""
