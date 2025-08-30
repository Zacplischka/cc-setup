#!/bin/bash

# Claude MCP Server Setup Script
# This script removes existing MCP servers and adds new ones with proper configuration

set -euo pipefail  # Exit on error, undefined vars, and pipe failures

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if required environment variables are set
check_env_vars() {
    local missing_vars=()
    
    if [[ -z "${CONTEXT7_API_KEY:-}" ]]; then
        missing_vars+=("CONTEXT7_API_KEY")
    fi
    
    if [[ -z "${GITHUB_TOKEN:-}" ]]; then
        missing_vars+=("GITHUB_TOKEN")
    fi
    
    if [[ ${#missing_vars[@]} -gt 0 ]]; then
        print_error "Missing required environment variables:"
        for var in "${missing_vars[@]}"; do
            echo "  - $var"
        done
        echo
        echo "Please set these variables before running the script:"
        echo "  export CONTEXT7_API_KEY='your_context7_api_key'"
        echo "  export GITHUB_TOKEN='your_github_token'"
        exit 1
    fi
}

# Function to remove MCP server with error handling
remove_mcp_server() {
    local server_name="$1"
    print_status "Removing MCP server: $server_name"
    
    if claude mcp remove "$server_name" 2>/dev/null; then
        print_status "Successfully removed $server_name"
    else
        print_warning "Server $server_name was not found or already removed"
    fi
}

# Function to add MCP server with error handling
add_mcp_server() {
    local server_name="$1"
    shift
    local server_args=("$@")
    
    print_status "Adding MCP server: $server_name"
    
    if claude mcp add "$server_name" "${server_args[@]}"; then
        print_status "Successfully added $server_name"
    else
        print_error "Failed to add $server_name"
        return 1
    fi
}

# Main execution
main() {
    print_status "Starting Claude MCP server setup"
    
    # Check environment variables
    check_env_vars
    
    # Remove existing MCP servers
    print_status "Removing existing MCP servers"
    remove_mcp_server "github"
    remove_mcp_server "context7" 
    remove_mcp_server "sentry"
    remove_mcp_server "serena"
    remove_mcp_server "brightdata"
    remove_mcp_server "sequential-thinking"
    
    echo
    print_status "Adding new MCP servers"
    
    # Add Context7 server
    add_mcp_server "context7" -- npx -y @upstash/context7-mcp --api-key "$CONTEXT7_API_KEY"
    
    # Add GitHub server  
    add_mcp_server "github" --transport http https://api.githubcopilot.com/mcp -H "Authorization: Bearer $GITHUB_TOKEN"
    
    # Add Sentry server
    add_mcp_server "sentry" --transport http https://mcp.sentry.dev/mcp
    
    # Add Serena server
    add_mcp_server "serena" -- uvx --from git+https://github.com/oraios/serena serena start-mcp-server --context ide-assistant --project "$(pwd)"
    
    # Add BrightData server
    add_mcp_server "brightdata" --transport sse 'https://mcp.brightdata.com/sse?token='$BRIGHT_API_KEY''
    
    # Add sequential thinking server
    add_mcp_server "sequential-thinking" -- npx -y @modelcontextprotocol/server-sequential-thinking
    
    echo
    print_status "MCP server setup completed successfully"
}

# Run main function
main "$@"



