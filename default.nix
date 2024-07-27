{ stdenv, cmake }:

stdenv.mkDerivation rec {
  pname = "easy_cmake";
  version = "0.1.0";
  src = ./.;
  nativeBuildInputs = [ cmake ];
}
