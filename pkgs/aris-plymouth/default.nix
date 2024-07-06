{ stdenv, lib }:
stdenv.mkDerivation {
  pname = "aris-plymouth";
  version = "2024.7.7";

  src = ./aris;

  installPhase = ''
    mkdir -p $out/share/plymouth/themes
    cp -r $src $out/share/plymouth/themes/aris
  '';

  meta = with lib; {
    description = "aris plymouth theme";
    homepage = "[WIP]";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
