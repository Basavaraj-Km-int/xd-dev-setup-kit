#!/bin/bash
# Intuit Design Prototype Scaffolding
# Usage: ./scaffold.sh my-prototype-name

set -e

PROJECT_NAME=${1:-"design-prototype"}
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🎨 Scaffolding Intuit Design Prototype: $PROJECT_NAME"
echo "=================================================="

# Create project with Vite + React + TypeScript
npm create vite@latest "$PROJECT_NAME" -- --template react-ts
cd "$PROJECT_NAME"

echo ""
echo "📁 Creating project structure..."

# Create directories
mkdir -p docs
mkdir -p src/{components,pages,layouts,hooks,mocks/data,lib,styles}
mkdir -p public

# Copy template files from scaffold directory
echo "📄 Installing CLAUDE.md and agents.md..."
cp "$SCRIPT_DIR/CLAUDE.md" ./CLAUDE.md
cp "$SCRIPT_DIR/agents.md" ./agents.md
cp "$SCRIPT_DIR/docs/PRD.md" ./docs/PRD.md
cp "$SCRIPT_DIR/docs/design.md" ./docs/design.md

# Create placeholder files
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

# .gitignore additions
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
GITEOF

echo ""
echo "📦 Installing dependencies..."
npm install

echo ""
echo "✅ Done! Your prototype is ready."
echo ""
echo "Next steps:"
echo "  cd $PROJECT_NAME"
echo "  1. Fill in docs/PRD.md with your product requirements"
echo "  2. Run: npm run dev"
echo "  3. Open Claude Code and start building from the PRD"
echo ""
echo "Useful commands:"
echo "  npm run dev        → Start dev server"
echo "  npm run build      → Production build"
echo "  npm run lint       → Lint code"
echo ""
echo "To add IDS components:"
echo "  npm install @ids-ts/button @ids-ts/text-field @ids-ts/typography"
echo ""
