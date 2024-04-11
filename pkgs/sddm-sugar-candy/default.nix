{
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation {
  pname = "sddm-sugar-candy";
  version = "master";

  src = fetchFromGitHub {
    owner = "Kangie";
    repo = "sddm-sugar-candy";
    rev = "master";
    sha256 = "18wsl2p9zdq2jdmvxl4r56lir530n73z9skgd7dssgq18lipnrx7";
  };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/sddm/themes
    cp -aR $src $out/share/sddm/themes/sugar-candy
  '';
}
