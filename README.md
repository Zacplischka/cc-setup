# Claude MCP Server Setup

This project provides an automated setup script for configuring Claude MCP (Model Context Protocol) servers with various integrations.

## Prerequisites

Before using the setup script, you need to obtain API keys from the following services:

1. **Context7 API Key**: Get from [https://context7.dev](https://context7.dev)
2. **GitHub Token**: Create a Personal Access Token from GitHub Settings > Developer Settings > Personal Access Tokens
   - Required scopes: `repo`, `read:org`, `read:user`
3. **BrightData API Key** (optional): Get from your BrightData dashboard

## Environment Setup

### 1. Export Required API Keys

Export the required environment variables in your terminal:

```bash
export CONTEXT7_API_KEY='your_context7_api_key_here'
export GITHUB_TOKEN='your_github_personal_access_token_here'
```

For BrightData (optional):
```bash
export BRIGHT_API_KEY='your_brightdata_api_key_here'
```

### 2. Persistent Environment Variables (Recommended)

To make these variables persistent across terminal sessions, add them to your shell profile:

**For bash users** (add to `~/.bashrc` or `~/.bash_profile`):
```bash
echo 'export CONTEXT7_API_KEY="your_context7_api_key_here"' >> ~/.bashrc
echo 'export GITHUB_TOKEN="your_github_personal_access_token_here"' >> ~/.bashrc
source ~/.bashrc
```

**For zsh users** (add to `~/.zshrc`):
```bash
echo 'export CONTEXT7_API_KEY="your_context7_api_key_here"' >> ~/.zshrc
echo 'export GITHUB_TOKEN="your_github_personal_access_token_here"' >> ~/.zshrc
source ~/.zshrc
```

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/Zacplischka/cc-setup.git
cd cc-setup
```

### 2. Make Script Globally Accessible

To use the `setup-cc` command from anywhere:

```bash
# Make the script executable
chmod +x setup_claude_mcp.sh

# Create a global symlink (replace /path/to/project with your actual path)
sudo ln -sf /path/to/project/setup_claude_mcp.sh /usr/local/bin/setup-cc
```

## Using the Setup Command

Once installed, you can run the setup script from any directory:

```bash
setup-cc
```

### What the Command Does

The `setup-cc` command will:

1. **Verify Environment Variables**: Check that required API keys are set
2. **Remove Existing Servers**: Clean up any previously configured MCP servers
3. **Add New Servers**: Configure the following MCP servers:
   - **context7**: Provides up-to-date documentation for libraries and frameworks
   - **github**: GitHub integration for repository management
   - **sentry**: Error monitoring and issue management
   - **serena**: IDE assistant with semantic coding tools
   - **brightdata**: Web scraping capabilities (if API key provided)
   - **sequential-thinking**: Advanced reasoning capabilities

### Example Usage

```bash
# Set your API keys
export CONTEXT7_API_KEY='ctx7sk-your-key-here'
export GITHUB_TOKEN='ghp_your-token-here'

# Run the setup
setup-cc
```

## Troubleshooting

### Missing Environment Variables

If you see an error about missing environment variables:

```
[ERROR] Missing required environment variables:
  - CONTEXT7_API_KEY
  - GITHUB_TOKEN
```

Make sure you've exported the required API keys as shown above.

### Command Not Found

If `setup-cc` command is not found, the global symlink may not be set up. Run:

```bash
# Check if command exists
which setup-cc

# If not found, create the symlink (replace with your actual project path)
sudo ln -sf /path/to/your/project/setup_claude_mcp.sh /usr/local/bin/setup-cc
```

### Verification

To verify everything is working correctly:

```bash
# Check if command is accessible
which setup-cc

# Verify environment variables are set
echo $CONTEXT7_API_KEY
echo $GITHUB_TOKEN

# Run the setup
setup-cc
```

## Security Notes

- Keep your API keys secure and never commit them to version control
- The `.env` file contains example values - replace with your actual keys
- Consider using a secrets manager for production environments

## API Key Sources

- **Context7**: [https://context7.dev](https://context7.dev) - Documentation service
- **GitHub**: [GitHub Settings > Developer Settings > Personal Access Tokens](https://github.com/settings/tokens)
- **BrightData**: Available in your BrightData dashboard
