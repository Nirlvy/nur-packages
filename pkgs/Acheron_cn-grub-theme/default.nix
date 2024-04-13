{
  lib,
  stdenv,
  fetchurl,
}:
stdenv.mkDerivation {
  pname = "Acheron_cn-grub-theme";
  version = "v2.0";

  src = fetchurl {
    url = "https://github.com/voidlhf/StarRailGrubThemes/releases/download/v2.0/Acheron_cn.tar.gz";
    sha256 = "sha256-OW+Owjp516FmwpB8dzlBEeqBsW/Qd/qDtnxQ3yLgutc=";
  };

  # src = fetchFromGitHub {
  #   owner = "voidlhf";
  #   repo = "StarRailGrubThemes";
  #   rev = "v2.1";
  #   # sha256 = "sha256-/KJ8KXK0yWJyv1jvXyWnK0+0zK8/5jqKXKqKXKqKXK";
  # };

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -r * $out

    runHook postInstall
  '';

  meta = {
    description = "A pack of GRUB2 themes for Honkai: Star Rail";
    homepage = "https://github.com/voidlhf/StarRailGrubThemes";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.linux;
  };
}
