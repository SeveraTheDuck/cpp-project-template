{
  description = "C++23 Template Environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        llvm = pkgs.llvmPackages_18;
      in
      {
        devShells.default = pkgs.mkShell.override { stdenv = llvm.stdenv; } {
          packages = with pkgs; [
            cmake
            ninja
            ccache

            llvm.clang-tools          # clang-format, clang-tidy, clangd
            cmake-format              # cmake-format
            editorconfig-checker      # Validate .editorconfig
            pre-commit                # git-hooks framework
          ];

          shellHook = ''
            echo "🚀 C++23 Env Loaded: Clang $(clang++ -dumpversion), CMake $(cmake --version | head -n 1 | awk '{print $3}')"

            if [ -d .git ]; then
              pre-commit install --hook-type pre-push > /dev/null
            fi
          '';
        };
      }
    );
}
