{ pkgs, llvm, commonPackages }:
{ stdenv, CC, CXX, extraPackages ? [], name }:

(pkgs.mkShell.override { inherit stdenv; }) {
  packages = commonPackages ++ extraPackages;
  inherit CC CXX;
  hardeningDisable = [ "all" ];

  shellHook = ''
    echo "--- C++ Dev Environment (${name}) ---"
    echo "CC:    $CC ($($CC -dumpversion))"
    echo "CXX:   $CXX ($($CXX -dumpversion))"
    echo "CMake: $(cmake --version | head -n 1 | awk '{print $3}')"
    echo "--------------------------------------"
    if [ -d .git ] && [ ! -L .git/hooks/pre-push ]; then
      pre-commit install --hook-type pre-push
    fi
  '';
}
