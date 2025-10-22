#!/usr/bin/env bash
# VS Code Extension Manager for Chezmoi
# Manages VS Code extensions in a reproducible way
#
# Usage:
#   ./manage-extensions.sh install   # Install all extensions from list
#   ./manage-extensions.sh export    # Export currently installed extensions
#   ./manage-extensions.sh sync      # Sync extensions (install missing, optionally remove extra)
#   ./manage-extensions.sh diff      # Show difference between installed and list

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EXTENSIONS_FILE="${SCRIPT_DIR}/extensions.txt"
VSCODE_SERVER="${HOME}/.vscode-server"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
print_section() {
    echo -e "\n${BLUE}=== $1 ===${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Check if code command is available
check_code_command() {
    if ! command -v code &> /dev/null; then
        print_error "VS Code 'code' command not found"
        print_warning "Make sure VS Code is installed and 'code' is in your PATH"
        print_warning "You may need to run: export PATH=\"\$PATH:/path/to/vscode/bin\""
        exit 1
    fi
}

# Get list of extensions from file (excluding comments and empty lines)
get_extension_list() {
    grep -v '^#' "$EXTENSIONS_FILE" | grep -v '^$' || true
}

# Get currently installed extensions
get_installed_extensions() {
    code --list-extensions 2>/dev/null || true
}

# Install all extensions from list
install_extensions() {
    print_section "Installing Extensions"

    local count=0
    local failed=0

    while IFS= read -r extension; do
        if [[ -z "$extension" ]]; then
            continue
        fi

        echo -n "Installing ${extension}... "
        if code --install-extension "$extension" &> /dev/null; then
            print_success "installed"
            ((count++))
        else
            print_error "failed"
            ((failed++))
        fi
    done < <(get_extension_list)

    print_section "Installation Summary"
    print_success "Installed: $count"
    if [[ $failed -gt 0 ]]; then
        print_error "Failed: $failed"
    fi
}

# Export currently installed extensions
export_extensions() {
    print_section "Exporting Installed Extensions"

    local output_file="${SCRIPT_DIR}/extensions-export-$(date +%Y%m%d-%H%M%S).txt"

    echo "# VS Code Extensions - Exported $(date)" > "$output_file"
    echo "# Total: $(code --list-extensions | wc -l)" >> "$output_file"
    echo "" >> "$output_file"

    code --list-extensions >> "$output_file"

    print_success "Exported to: $output_file"
    print_warning "Review and merge into extensions.txt if needed"
}

# Show diff between installed and listed extensions
diff_extensions() {
    print_section "Extension Diff"

    local listed=$(get_extension_list | sort)
    local installed=$(get_installed_extensions | sort)

    # Extensions in list but not installed
    local missing=$(comm -23 <(echo "$listed") <(echo "$installed"))
    if [[ -n "$missing" ]]; then
        echo -e "\n${YELLOW}Missing (in list but not installed):${NC}"
        echo "$missing" | while read -r ext; do
            echo "  - $ext"
        done
    else
        print_success "All listed extensions are installed"
    fi

    # Extensions installed but not in list
    local extra=$(comm -13 <(echo "$listed") <(echo "$installed"))
    if [[ -n "$extra" ]]; then
        echo -e "\n${BLUE}Extra (installed but not in list):${NC}"
        echo "$extra" | while read -r ext; do
            echo "  + $ext"
        done
    else
        print_success "No extra extensions installed"
    fi
}

# Sync extensions (install missing)
sync_extensions() {
    print_section "Syncing Extensions"

    local listed=$(get_extension_list | sort)
    local installed=$(get_installed_extensions | sort)

    # Install missing extensions
    local missing=$(comm -23 <(echo "$listed") <(echo "$installed"))

    if [[ -z "$missing" ]]; then
        print_success "All extensions are already installed"
        return 0
    fi

    echo -e "\n${YELLOW}Installing missing extensions:${NC}"
    echo "$missing" | while read -r extension; do
        if [[ -n "$extension" ]]; then
            echo -n "Installing ${extension}... "
            if code --install-extension "$extension" &> /dev/null; then
                print_success "done"
            else
                print_error "failed"
            fi
        fi
    done

    # Optional: Ask to remove extra extensions
    local extra=$(comm -13 <(echo "$listed") <(echo "$installed"))
    if [[ -n "$extra" ]]; then
        echo -e "\n${BLUE}Extra extensions found:${NC}"
        echo "$extra"

        read -rp "$(echo -e ${YELLOW}Do you want to remove extra extensions? [y/N]:${NC} )" response
        if [[ "$response" =~ ^[Yy]$ ]]; then
            echo "$extra" | while read -r extension; do
                if [[ -n "$extension" ]]; then
                    echo -n "Uninstalling ${extension}... "
                    if code --uninstall-extension "$extension" &> /dev/null; then
                        print_success "done"
                    else
                        print_error "failed"
                    fi
                fi
            done
        fi
    fi
}

# Show usage
show_usage() {
    cat << EOF
VS Code Extension Manager

Usage: $0 <command>

Commands:
    install     Install all extensions from extensions.txt
    export      Export currently installed extensions to a file
    sync        Sync extensions (install missing, optionally remove extra)
    diff        Show difference between installed and listed extensions
    help        Show this help message

Examples:
    $0 install          # Install all extensions
    $0 sync             # Sync extensions
    $0 diff             # Check what's different

Extension list: $EXTENSIONS_FILE
EOF
}

# Main script
main() {
    # Check if extensions file exists
    if [[ ! -f "$EXTENSIONS_FILE" ]]; then
        print_error "Extensions file not found: $EXTENSIONS_FILE"
        exit 1
    fi

    # Check for code command
    check_code_command

    # Parse command
    case "${1:-help}" in
        install)
            install_extensions
            ;;
        export)
            export_extensions
            ;;
        sync)
            sync_extensions
            ;;
        diff)
            diff_extensions
            ;;
        help|--help|-h)
            show_usage
            ;;
        *)
            print_error "Unknown command: $1"
            show_usage
            exit 1
            ;;
    esac
}

# Run main function
main "$@"
