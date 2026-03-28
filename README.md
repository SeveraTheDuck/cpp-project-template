# C++23 Modern Project Template

By **SeveraTheDuck** 🦆

This template utilizes **Nix Flakes** for deterministic environments and a **CI/CD pipeline** to ensure industrial-grade code quality.

[![Pipeline Status](https://github.com/YOUR_USERNAME/YOUR_REPO/actions/workflows/pipeline.yml/badge.svg)](https://github.com/YOUR_USERNAME/YOUR_REPO/actions)
[![Security Analysis](https://github.com/YOUR_USERNAME/YOUR_REPO/actions/workflows/codeql.yml/badge.svg)](https://github.com/YOUR_USERNAME/YOUR_REPO/actions)
![C++ Standard](https://img.shields.io/badge/C%2B%2B-23-blue.svg)
![Build System](https://img.shields.io/badge/CMake-3.28%2B-green.svg)
![Environment](https://img.shields.io/badge/Nix-Flakes-orange.svg)

---

## Key Features

* **Standard:** C++23 by default, but you are able to change it.
* **Reproducible Environment:** **Nix Flakes** ensures that every developer and CI runner uses the exact same compiler versions, libraries, and tools.
* **Zero-Install Workflow:** Integrated with `direnv`. Just `cd` into the folder, and your environment (CMake, Ninja, Linter, etc.) is ready.
* **Dependency Management:** Handled natively via Nix (Nixpkgs). No `vcpkg` or `conan` bloat—just pure, cached, binary-reproducible libraries.
* **Quality Gates:**
  * **Pre-push Hooks:** Automatic formatting (`clang-format`) and static analysis (`clang-tidy`) before code leaves your machine.
  * **Semantic Analysis:** **GitHub CodeQL** integrated to detect deep logic flaws and security vulnerabilities.
* **Documentation:** **Doxygen** with the **Doxygen Awesome** theme and full **LaTeX** support for mathematical notation.

---

## Tech Stack

| Tool | Description |
| :--- | :--- |
| **Build System** | CMake 3.28+ (with `CMakePresets.json`) |
| **Generators** | Ninja (fast parallel builds) |
| **Compilers** | LLVM Clang 21 & GCC 14/15 |
| **Testing** | Google Test (GTest) |
| **Static Analysis** | Clang-Tidy, CodeQL |
| **Documentation** | Doxygen + Doxygen Awesome + MathJax |

---

## Project Structure

Following the flat layout:

```text
.
├── .github/workflows/   # CI/CD (Pipeline, CodeQL, Docs)
├── cmake/               # Modular CMake configuration
├── docs/                # Documentation assets & themes
├── source/              # Application source code
│   └── engine/          # Example project name
├── tests/               # Unit & Integration tests
├── flake.nix            # Nix environment & dependencies
├── Doxyfile             # Documentation config
└── CMakePresets.json    # Build & Test configurations
```

---

## Quick Start

### 1. Environment Setup

You need the Nix package manager with Flakes enabled.

```bash
# Recommended: install direnv to load the environment automatically
direnv allow

# Or manually enter the shell
nix develop
```

### 2. Build & Test

Use CMake presets for consistent builds across all platforms:

```bash
# Configure the project (Dev mode)
cmake --preset dev

# Build
cmake --build --preset dev -j$(nproc)

# Run tests
ctest --preset dev
```

### 3. Documentation

Generate the documentation site locally:

```bash
doxygen Doxyfile
# Output will be in docs_output/html/index.html
```

---

## CI/CD Architecture

The repository implements a strict "Lint-then-Build" logic:

1. **Linting:** Validates formatting and runs `clang-tidy`. If this fails, no compute resources are wasted on building.
2. **Matrix Build:** Parallel compilation on both **Clang** and **GCC**.
3. **Sanitizers:** Automatic testing with **AddressSanitizer (ASan)** and **UndefinedBehaviorSanitizer (UBSan)**.
4. **Security:** Scheduled **CodeQL** scans to analyze data-flow and logic.
5. **Auto-Deploy:** On every push to `main`, documentation is automatically updated and deployed to **GitHub Pages**.

---

License: [The Unlicense](LICENSE). Feel free to use and change this template.
