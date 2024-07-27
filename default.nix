{ stdenv, cmake }:

stdenv.mkDerivation rec {
  pname = "cmake_macros";
  version = "0.1.0";
  src = ./.;
  nativeBuildInputs = [ cmake ];
}
