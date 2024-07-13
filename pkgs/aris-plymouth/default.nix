{ stdenv, lib }:
stdenv.mkDerivation {
  pname = "aris-plymouth";
  version = "2024.7.14";

  src = ./aris;

  installPhase = ''
    mkdir -p $out/share/plymouth/themes
    cp -r $src $out/share/plymouth/themes/aris
    chmod -R 755 $out
    find $out/share/plymouth/themes/aris -name aris.plymouth -exec sed -i "s@\/usr\/@$out\/@" {} \;
  '';

  meta = with lib; {
    description = "aris plymouth theme";
    homepage = "[WIP]";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
