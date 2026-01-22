#!/bin/bash
set -e

echo "=== CrossCheck Installer ==="
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Version pinning (update these as needed)
CODEX_VERSION="0.1"
GEMINI_CLI_VERSION="0.1"
GEMINI_MCP_VERSION="0.1.8"

# Check Node.js
if ! command -v node &> /dev/null; then
    echo -e "${RED}Error: Node.js is required. Install from https://nodejs.org${NC}"
    exit 1
fi

echo "Node.js version: $(node --version)"
echo ""

# Install Codex CLI
echo "Installing Codex CLI (@openai/codex@${CODEX_VERSION})..."
if ! command -v codex &> /dev/null; then
    npm install -g @openai/codex@${CODEX_VERSION}
    echo -e "${GREEN}✓ Codex CLI installed${NC}"
else
    echo -e "${GREEN}✓ Codex CLI already installed${NC} ($(codex --version 2>/dev/null || echo 'unknown'))"
fi

# Install Gemini CLI
echo "Installing Gemini CLI (@google/gemini-cli@${GEMINI_CLI_VERSION})..."
if ! command -v gemini &> /dev/null; then
    npm install -g @google/gemini-cli@${GEMINI_CLI_VERSION}
    echo -e "${GREEN}✓ Gemini CLI installed${NC}"
else
    echo -e "${GREEN}✓ Gemini CLI already installed${NC}"
fi

# Add MCP servers to Claude Code
echo ""
echo "Configuring MCP servers..."

# Check for existing MCP configs and warn user
if claude mcp list 2>/dev/null | grep -q "codex"; then
    echo -e "${YELLOW}Warning: Existing 'codex' MCP config found. It will be replaced.${NC}"
fi
if claude mcp list 2>/dev/null | grep -q "gemini"; then
    echo -e "${YELLOW}Warning: Existing 'gemini' MCP config found. It will be replaced.${NC}"
fi

# Remove existing (ignore errors)
claude mcp remove codex 2>/dev/null || true
claude mcp remove gemini 2>/dev/null || true

# Add fresh
claude mcp add codex -- codex mcp-server
echo -e "${GREEN}✓ Codex MCP added${NC}"

claude mcp add gemini -- npx -y gemini-mcp-tool@${GEMINI_MCP_VERSION}
echo -e "${GREEN}✓ Gemini MCP added${NC}"

# Verify
echo ""
echo "Verifying MCP connections..."
claude mcp list | grep -E "(codex|gemini)" || echo -e "${YELLOW}Warning: Could not verify MCP connections${NC}"

echo ""
echo -e "${GREEN}=== Installation Complete ===${NC}"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Login to Codex:  codex"
echo "2. Login to Gemini: gemini"
echo "3. Restart Claude Code: /exit then 'claude'"
echo "4. Test: /crosscheck What is 2+2?"
