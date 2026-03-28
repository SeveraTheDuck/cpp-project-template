{
  description = "C++23 Template Environment (Linux Only)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        llvm = pkgs.llvmPackages_latest;
        gcc = pkgs.gcc14;
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            cmake
            ninja
            ccache

            llvm.clang        # clang, clang++
            gcc               # gcc, g++
            
            llvm.clang-tools  # clang-format, clang-tidy, clangd
            cmake-format
            editorconfig-checker
            pre-commit

            gtest
          ];

          shellHook = ''
            echo "C++23 Environment Loaded"
            echo "Clang: $(clang++ -dumpversion)"
            echo "GCC:   $(g++ -dumpversion)"
            echo "CMake: $(cmake --version | head -n 1 | awk '{print $3}')"

            if [ -d .git ]; then
              pre-commit install --hook-type pre-push > /dev/null
            fi
          '';
        };
      }
    );
}
