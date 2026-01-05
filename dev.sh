#!/bin/bash

# Vibe Notes Development Helper Script

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_info() {
    echo -e "${BLUE}ℹ ${1}${NC}"
}

print_success() {
    echo -e "${GREEN}✓ ${1}${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ ${1}${NC}"
}

print_error() {
    echo -e "${RED}✗ ${1}${NC}"
}

# Check if Flutter is installed
check_flutter() {
    if ! command -v flutter &> /dev/null; then
        print_error "Flutter is not installed. Please install Flutter first."
        exit 1
    fi
    print_success "Flutter is installed"
}

# Load environment variables
load_env() {
    if [ -f .env ]; then
        export $(cat .env | grep -v '^#' | xargs)
        print_success "Loaded environment variables from .env"
    else
        print_warning "No .env file found. Using .env.example as template."
        if [ -f .env.example ]; then
            cp .env.example .env
            print_info "Created .env file from .env.example"
            print_warning "Please edit .env and add your Supabase credentials"
            exit 0
        fi
    fi
}

# Validate environment variables
validate_env() {
    if [ -z "$SUPABASE_URL" ] || [ "$SUPABASE_URL" = "YOUR_SUPABASE_URL" ]; then
        print_error "SUPABASE_URL is not set or is using default value"
        print_info "Please edit .env and set your Supabase URL"
        exit 1
    fi
    
    if [ -z "$SUPABASE_ANON_KEY" ] || [ "$SUPABASE_ANON_KEY" = "YOUR_SUPABASE_ANON_KEY" ]; then
        print_error "SUPABASE_ANON_KEY is not set or is using default value"
        print_info "Please edit .env and set your Supabase anon key"
        exit 1
    fi
    
    print_success "Environment variables are set"
}

# Install dependencies
install_deps() {
    print_info "Installing dependencies..."
    flutter pub get
    print_success "Dependencies installed"
}

# Run tests
run_tests() {
    print_info "Running tests..."
    flutter test
    print_success "Tests passed"
}

# Analyze code
analyze_code() {
    print_info "Analyzing code..."
    flutter analyze
    print_success "Code analysis passed"
}

# Format code
format_code() {
    print_info "Formatting code..."
    dart format lib/ test/
    print_success "Code formatted"
}

# Run the app
run_app() {
    local device=${1:-""}
    
    print_info "Running app..."
    if [ -n "$device" ]; then
        flutter run -d "$device" \
            --dart-define=SUPABASE_URL="$SUPABASE_URL" \
            --dart-define=SUPABASE_ANON_KEY="$SUPABASE_ANON_KEY"
    else
        flutter run \
            --dart-define=SUPABASE_URL="$SUPABASE_URL" \
            --dart-define=SUPABASE_ANON_KEY="$SUPABASE_ANON_KEY"
    fi
}

# Build app
build_app() {
    local platform=${1:-"apk"}
    
    print_info "Building app for $platform..."
    case $platform in
        apk)
            flutter build apk --release \
                --dart-define=SUPABASE_URL="$SUPABASE_URL" \
                --dart-define=SUPABASE_ANON_KEY="$SUPABASE_ANON_KEY"
            ;;
        ios)
            flutter build ios --release \
                --dart-define=SUPABASE_URL="$SUPABASE_URL" \
                --dart-define=SUPABASE_ANON_KEY="$SUPABASE_ANON_KEY"
            ;;
        web)
            flutter build web --release \
                --dart-define=SUPABASE_URL="$SUPABASE_URL" \
                --dart-define=SUPABASE_ANON_KEY="$SUPABASE_ANON_KEY"
            ;;
        *)
            print_error "Unknown platform: $platform"
            print_info "Available platforms: apk, ios, web"
            exit 1
            ;;
    esac
    print_success "Build completed"
}

# Show help
show_help() {
    echo "Vibe Notes Development Helper"
    echo ""
    echo "Usage: ./dev.sh [command] [options]"
    echo ""
    echo "Commands:"
    echo "  setup              - Set up environment and install dependencies"
    echo "  run [device]       - Run the app on specified device (or default)"
    echo "  test               - Run tests"
    echo "  analyze            - Analyze code"
    echo "  format             - Format code"
    echo "  build [platform]   - Build app (apk, ios, web)"
    echo "  check              - Run tests and analyze code"
    echo "  help               - Show this help message"
    echo ""
    echo "Examples:"
    echo "  ./dev.sh setup"
    echo "  ./dev.sh run"
    echo "  ./dev.sh run chrome"
    echo "  ./dev.sh build apk"
    echo "  ./dev.sh check"
}

# Main script logic
main() {
    local command=${1:-"help"}
    
    case $command in
        setup)
            check_flutter
            load_env
            validate_env
            install_deps
            print_success "Setup complete! You can now run: ./dev.sh run"
            ;;
        run)
            check_flutter
            load_env
            validate_env
            run_app "$2"
            ;;
        test)
            check_flutter
            run_tests
            ;;
        analyze)
            check_flutter
            analyze_code
            ;;
        format)
            check_flutter
            format_code
            ;;
        build)
            check_flutter
            load_env
            validate_env
            build_app "$2"
            ;;
        check)
            check_flutter
            run_tests
            analyze_code
            print_success "All checks passed!"
            ;;
        help|--help|-h)
            show_help
            ;;
        *)
            print_error "Unknown command: $command"
            show_help
            exit 1
            ;;
    esac
}

# Run main function
main "$@"
