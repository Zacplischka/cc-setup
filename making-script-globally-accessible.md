# Making setup_claude_mcp.sh Globally Accessible

This document explains how to make the `setup_claude_mcp.sh` script executable from anywhere in the terminal using the command `setup-cc`.

## Overview

The goal was to make the Claude MCP server setup script accessible from any directory in the terminal by typing `setup-cc` instead of having to navigate to the script's directory and run `./setup_claude_mcp.sh`.

## Steps Performed

### 1. Make the Script Executable

First, we added execute permissions to the script:

```bash
chmod +x /path/to/project/setup_claude_mcp.sh
```

This command gives the script file execute permissions, allowing it to be run directly.

### 2. Create a Global Symlink

Next, we created a symbolic link in `/usr/local/bin/`, which is typically included in the system's PATH:

```bash
sudo ln -sf /path/to/project/setup_claude_mcp.sh /usr/local/bin/setup-cc
```

**Command breakdown:**
- `sudo`: Required administrator privileges to write to `/usr/local/bin/`
- `ln`: The link command
- `-s`: Create a symbolic (soft) link
- `-f`: Force creation, overwriting any existing file with the same name
- First argument: Source file (the original script)
- Second argument: Target location and name (the global command name)

### 3. Verify the Setup

We tested that the command works from any directory:

```bash
cd / && which setup-cc
```

This confirmed that:
- The command `setup-cc` is found in the PATH
- It points to `/usr/local/bin/setup-cc`
- The symlink correctly references our original script

### 4. Test Execution

Finally, we ran the command to ensure it executes properly:

```bash
setup-cc
```

The script ran successfully, setting up all the MCP servers as expected.

## How It Works

### PATH Environment Variable

The `PATH` environment variable contains a list of directories that the shell searches when you type a command. Common directories in PATH include:
- `/usr/local/bin`
- `/usr/bin`
- `/bin`

By placing our symlink in `/usr/local/bin`, the shell can find and execute our script from anywhere.

### Symbolic Links

A symbolic link (symlink) is a file that points to another file or directory. When you execute the symlink, it redirects to the original file. This allows us to:
- Keep the original script in its project directory
- Make it accessible globally without duplicating the file
- Maintain a single source of truth for the script

## Benefits

1. **Global Access**: Can run `setup-cc` from any directory
2. **Clean Command**: Simple, memorable command name
3. **No Duplication**: Original script stays in place, no file copying needed
4. **Easy Updates**: Changes to the original script are immediately available globally
5. **Standard Practice**: Uses conventional Unix/Linux approach for global commands

## Alternative Approaches

Other methods that could have been used:

1. **Adding the script directory to PATH**: 
   ```bash
   export PATH="$PATH:/path/to/project"
   ```

2. **Copying the script to a PATH directory** (not recommended due to duplication)

3. **Creating an alias** (only works in the current shell session unless added to shell config)

## Maintenance

To update the globally accessible command:
- Simply modify the original `setup_claude_mcp.sh` file
- Changes will be immediately available when running `setup-cc`

To remove the global command:
```bash
sudo rm /usr/local/bin/setup-cc
```

## Verification Commands

To check if everything is working:

```bash
# Check if command is found
which setup-cc

# Check if symlink is correct
ls -la /usr/local/bin/setup-cc

# Test execution
setup-cc
```
