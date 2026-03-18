#!/bin/bash
# XD Dev Setup Kit — Intuit Design Prototype Scaffolding
# Usage: Clone the template, rename the folder, cd into it, then run ./scaffold.sh
#
# Prerequisites:
#   - Node.js 18+ (check: node --version)
#   - Git authenticated with github.intuit.com (see README)

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_NAME="$(basename "$SCRIPT_DIR")"
IDS_REPO="https://github.intuit.com/design-systems/ids-web.git"
IDS_DIR="int-design-system"

echo "🎨 Setting up: $PROJECT_NAME"
echo "=================================================="

# -------------------------------------------------------------------
# Step 1: Scaffold Vite + React + TypeScript in current directory
# -------------------------------------------------------------------
echo ""
echo "📦 Creating React + TypeScript project..."

# Create Vite project in a temp folder, then move contents here
TEMP_DIR="/tmp/xd-scaffold-$$"
rm -rf "$TEMP_DIR"
mkdir -p "$TEMP_DIR"

# Vite needs to run from /tmp to avoid relative path issues
(cd /tmp && npm create vite@latest "xd-scaffold-$$/app" -- --template react-ts)

# Move Vite files into current directory (skip files we already have)
cp -n "$TEMP_DIR/app/package.json" ./package.json 2>/dev/null || true
cp -n "$TEMP_DIR/app/tsconfig.json" ./tsconfig.json 2>/dev/null || true
cp -n "$TEMP_DIR/app/tsconfig.app.json" ./tsconfig.app.json 2>/dev/null || true
cp -n "$TEMP_DIR/app/tsconfig.node.json" ./tsconfig.node.json 2>/dev/null || true
cp -n "$TEMP_DIR/app/vite.config.ts" ./vite.config.ts 2>/dev/null || true
cp -n "$TEMP_DIR/app/eslint.config.js" ./eslint.config.js 2>/dev/null || true
cp -n "$TEMP_DIR/app/index.html" ./index.html 2>/dev/null || true
cp -rn "$TEMP_DIR/app/src/" ./src/ 2>/dev/null || true
cp -rn "$TEMP_DIR/app/public/" ./public/ 2>/dev/null || true

# Copy .gitignore from Vite
if [ -f "$TEMP_DIR/app/.gitignore" ]; then
  cp "$TEMP_DIR/app/.gitignore" ./.gitignore
fi

rm -rf "$TEMP_DIR"

# -------------------------------------------------------------------
# Step 2: Create project structure
# -------------------------------------------------------------------
echo ""
echo "📁 Creating project structure..."

mkdir -p docs
mkdir -p src/{components,pages,layouts,hooks,mocks/data,lib,styles}
mkdir -p public

# -------------------------------------------------------------------
# Step 3: Clone IDS Design System (for component reference)
# -------------------------------------------------------------------
echo ""
echo "📚 Cloning Intuit Design System (IDS) for component reference..."
echo "   This requires authentication with github.intuit.com"
echo ""

if git clone --depth 1 "$IDS_REPO" "$IDS_DIR" 2>/dev/null; then
  echo "✅ IDS cloned to $IDS_DIR/"
  echo "" >> .gitignore
  echo "# IDS design system clone (local reference only, do not commit)" >> .gitignore
  echo "int-design-system/" >> .gitignore
else
  echo ""
  echo "⚠️  Could not clone IDS. This is likely an authentication issue."
  echo ""
  echo "   To fix, run ONE of these and then clone manually:"
  echo ""
  echo "   Option 1 (recommended):"
  echo "     gh auth login --hostname github.intuit.com"
  echo ""
  echo "   Option 2 (manual):"
  echo "     1. Go to github.intuit.com/settings/tokens"
  echo "     2. Generate a token with 'repo' scope"
  echo "     3. Run: git clone https://YOUR_TOKEN@github.intuit.com/design-systems/ids-web.git int-design-system"
  echo ""
  echo "   Continuing without IDS clone — the prototype will still work,"
  echo "   but Claude Code won't be able to read component docs locally."
  echo ""
fi

# -------------------------------------------------------------------
# Step 4: Create starter files
# -------------------------------------------------------------------
echo "📝 Creating starter files..."

# Mock data example
cat > src/mocks/data/example.json << 'MOCKEOF'
{
  "users": [
    { "id": "1", "name": "Alice Johnson", "email": "alice@example.com" },
    { "id": "2", "name": "Srinivasaraghavan Subramanian", "email": "srini@example.com" }
  ]
}
MOCKEOF

# Global styles placeholder
cat > src/styles/global.css << 'STYLEEOF'
/* Global styles -- use IDS design tokens */

:root {
  /* Override only if needed for prototype-specific tokens */
}

* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

body {
  font-family: var(--font-family-component, -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif);
}

/* Accessibility: respect motion preferences */
@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration: 0.01ms !important;
    transition-duration: 0.01ms !important;
  }
}

/* Skip to content link */
.skip-to-content {
  position: absolute;
  top: -40px;
  left: 0;
  padding: 8px 16px;
  z-index: 100;
}

.skip-to-content:focus {
  top: 0;
}
STYLEEOF

# App.tsx starter
cat > src/App.tsx << 'APPEOF'
import './styles/global.css';

function App() {
  return (
    <main>
      <a href="#main-content" className="skip-to-content">
        Skip to content
      </a>
      <div id="main-content">
        <h1>Prototype</h1>
        <p>Read docs/PRD.md and docs/design.md to get started.</p>
      </div>
    </main>
  );
}

export default App;
APPEOF

# Add extra gitignore entries
cat >> .gitignore << 'GITEOF'

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

# Template files (not needed after scaffold)
scaffold.sh
GITEOF

# -------------------------------------------------------------------
# Step 5: Install dependencies
# -------------------------------------------------------------------
echo ""
echo "📦 Installing dependencies..."
npm install

# -------------------------------------------------------------------
# Done
# -------------------------------------------------------------------
echo ""
echo "✅ Done! $PROJECT_NAME is ready."
echo ""
echo "Next steps:"
echo "  1. Open in VS Code: code ."
echo "  2. Fill in docs/PRD.md with your product requirements"
echo "  3. Run: npm run dev"
echo "  4. Open Claude Code and start building from the PRD"
echo ""
echo "Useful commands:"
echo "  npm run dev        → Start dev server"
echo "  npm run build      → Production build"
echo "  npm run lint       → Lint code"
echo ""
echo "To add IDS components:"
echo "  npm install @ids-ts/button @ids-ts/text-field @ids-ts/typography"
echo ""
if [ ! -d "$IDS_DIR" ]; then
  echo "⚠️  Remember to clone IDS when you have GitHub Enterprise access:"
  echo "  git clone --depth 1 $IDS_REPO $IDS_DIR"
  echo ""
fi
