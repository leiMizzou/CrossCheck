#!/bin/bash
set -e

echo "=== CrossCheck Installer ==="
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Check Node.js
if ! command -v node &> /dev/null; then
    echo "Error: Node.js is required. Install from https://nodejs.org"
    exit 1
fi

# Install Codex CLI
echo "Installing Codex CLI..."
if ! command -v codex &> /dev/null; then
    npm install -g @openai/codex
    echo -e "${GREEN}✓ Codex CLI installed${NC}"
else
    echo -e "${GREEN}✓ Codex CLI already installed${NC} ($(codex --version))"
fi

# Install Gemini CLI
echo "Installing Gemini CLI..."
if ! command -v gemini &> /dev/null; then
    npm install -g @google/gemini-cli
    echo -e "${GREEN}✓ Gemini CLI installed${NC}"
else
    echo -e "${GREEN}✓ Gemini CLI already installed${NC}"
fi

# Add MCP servers to Claude Code
echo ""
echo "Configuring MCP servers..."

# Remove existing (ignore errors)
claude mcp remove codex 2>/dev/null || true
claude mcp remove gemini 2>/dev/null || true

# Add fresh
claude mcp add codex -- codex mcp-server
echo -e "${GREEN}✓ Codex MCP added${NC}"

claude mcp add gemini -- npx -y gemini-mcp-tool
echo -e "${GREEN}✓ Gemini MCP added${NC}"

# Verify
echo ""
echo "Verifying MCP connections..."
claude mcp list | grep -E "(codex|gemini)"

echo ""
echo -e "${GREEN}=== Installation Complete ===${NC}"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Login to Codex:  codex"
echo "2. Login to Gemini: gemini"
echo "3. Restart Claude Code: /exit then 'claude'"
echo "4. Test: /crosscheck What is 2+2?"
