#!/usr/bin/env bash
#
# run-tests.sh -- Test & QA automation runner for World of Warcraft addons
# Runs Luacheck static analysis and Busted unit tests in WSL 2 / Linux / CI.
#
# Usage:
#   ./scripts/run-tests.sh                    # Run lint and tests for all addons
#   ./scripts/run-tests.sh GoldFinder         # Run lint and tests for GoldFinder only
#   ./scripts/run-tests.sh --lint-only        # Run Luacheck only
#   ./scripts/run-tests.sh --test-only        # Run Busted tests only
#   ./scripts/run-tests.sh --strict           # Fail if any lint warnings exist
#

set -o pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
cd "${REPO_ROOT}"

# Formatting colors
CLR_RESET="\033[0m"
CLR_BOLD="\033[1m"
CLR_GREEN="\033[32m"
CLR_YELLOW="\033[33m"
CLR_RED="\033[31m"
CLR_CYAN="\033[36m"

TARGET_ADDON=""
RUN_LINT=true
RUN_TESTS=true
STRICT_LINT=false

# Parse command line arguments
for arg in "$@"; do
    case "$arg" in
        --lint-only)
            RUN_TESTS=false
            ;;
        --test-only)
            RUN_LINT=false
            ;;
        --strict)
            STRICT_LINT=true
            ;;
        --help|-h)
            echo "Usage: $0 [AddonName] [--lint-only] [--test-only] [--strict]"
            echo ""
            echo "Options:"
            echo "  AddonName     Target specific addon under addons/ (e.g. GoldFinder)"
            echo "  --lint-only   Execute Luacheck static analysis only"
            echo "  --test-only   Execute Busted unit tests only"
            echo "  --strict      Treat Luacheck warnings as errors"
            exit 0
            ;;
        -*)
            echo -e "${CLR_RED}Unknown option: $arg${CLR_RESET}" >&2
            exit 1
            ;;
        *)
            TARGET_ADDON="$arg"
            ;;
    esac
done

echo -e "${CLR_BOLD}${CLR_CYAN}======================================================${CLR_RESET}"
echo -e "${CLR_BOLD}${CLR_CYAN}   World of Warcraft Addon QA & Test Runner${CLR_RESET}"
echo -e "${CLR_BOLD}${CLR_CYAN}======================================================${CLR_RESET}"

# Verify tool availability
MISSING_TOOLS=()
command -v lua >/dev/null 2>&1 || MISSING_TOOLS+=("lua")
command -v luacheck >/dev/null 2>&1 || MISSING_TOOLS+=("luacheck")
command -v busted >/dev/null 2>&1 || MISSING_TOOLS+=("busted")

if [ ${#MISSING_TOOLS[@]} -gt 0 ]; then
    echo -e "${CLR_RED}Missing required tools:${CLR_RESET} ${MISSING_TOOLS[*]}" >&2
    echo "Install via: apt-get install -y lua5.1 luarocks lua-check && luarocks --lua-version=5.1 install busted" >&2
    exit 2
fi

LUA_VER="$(lua -v 2>&1 | head -n1)"
LUACHECK_VER="$(luacheck --version 2>&1 | head -n1)"
BUSTED_VER="$(busted --version 2>&1 | head -n1)"

echo -e "Runtime:   ${CLR_GREEN}${LUA_VER}${CLR_RESET}"
echo -e "Linter:    ${CLR_GREEN}${LUACHECK_VER}${CLR_RESET}"
echo -e "Test FW:   ${CLR_GREEN}Busted ${BUSTED_VER}${CLR_RESET}"
echo ""

LINT_STATUS=0
TEST_STATUS=0

# Determine targets
if [ -n "$TARGET_ADDON" ]; then
    if [ ! -d "addons/${TARGET_ADDON}" ]; then
        echo -e "${CLR_RED}Error: Addon folder 'addons/${TARGET_ADDON}' does not exist.${CLR_RESET}" >&2
        exit 1
    fi
    LINT_TARGET="addons/${TARGET_ADDON}"
    BUSTED_TARGET="addons/${TARGET_ADDON}"
    echo -e "Target Addon: ${CLR_BOLD}${TARGET_ADDON}${CLR_RESET}"
else
    LINT_TARGET="addons"
    BUSTED_TARGET="addons"
    echo -e "Target Addon: ${CLR_BOLD}All Addons (Monorepo)${CLR_RESET}"
fi
echo ""

# -----------------------------------------------------------------------------
# 1. Luacheck Linting
# -----------------------------------------------------------------------------
if [ "$RUN_LINT" = true ]; then
    echo -e "${CLR_BOLD}1. Running Luacheck Static Analysis...${CLR_RESET}"
    set +e
    luacheck "${LINT_TARGET}"
    LINT_EXIT=$?
    set -e

    if [ $LINT_EXIT -eq 0 ]; then
        echo -e "${CLR_GREEN}✓ Luacheck passed: 0 warnings, 0 errors.${CLR_RESET}"
        LINT_STATUS=0
    elif [ $LINT_EXIT -eq 1 ]; then
        if [ "$STRICT_LINT" = true ]; then
            echo -e "${CLR_RED}✗ Luacheck failed with warnings (strict mode enabled).${CLR_RESET}"
            LINT_STATUS=1
        else
            echo -e "${CLR_YELLOW}⚠ Luacheck completed with warnings (non-fatal; use --strict to enforce).${CLR_RESET}"
            LINT_STATUS=0
        fi
    else
        echo -e "${CLR_RED}✗ Luacheck encountered syntax or configuration errors (code $LINT_EXIT).${CLR_RESET}"
        LINT_STATUS=2
    fi
    echo ""
fi

# -----------------------------------------------------------------------------
# 2. Busted Unit Tests
# -----------------------------------------------------------------------------
if [ "$RUN_TESTS" = true ]; then
    echo -e "${CLR_BOLD}2. Running Busted Unit Tests...${CLR_RESET}"
    set +e
    busted "${BUSTED_TARGET}"
    TEST_EXIT=$?
    set -e

    if [ $TEST_EXIT -eq 0 ]; then
        echo -e "${CLR_GREEN}✓ All unit tests passed cleanly.${CLR_RESET}"
        TEST_STATUS=0
    else
        echo -e "${CLR_RED}✗ Busted test suite failed (code $TEST_EXIT).${CLR_RESET}"
        TEST_STATUS=1
    fi
    echo ""
fi

# -----------------------------------------------------------------------------
# Summary & Exit
# -----------------------------------------------------------------------------
echo -e "${CLR_BOLD}${CLR_CYAN}------------------------------------------------------${CLR_RESET}"
if [ $LINT_STATUS -eq 0 ] && [ $TEST_STATUS -eq 0 ]; then
    echo -e "${CLR_BOLD}${CLR_GREEN}QA SUITE PASSED!${CLR_RESET}"
    exit 0
else
    echo -e "${CLR_BOLD}${CLR_RED}QA SUITE FAILED.${CLR_RESET}"
    exit 1
fi
