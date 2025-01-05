{
  stdenvNoCC,
  fetchFromGitHub,
  lib,
  background ? null,
  ScreenWidth ? "1920",
  ScreenHeight ? "1080",
  FormPosition ? "left",
  InterfaceShadowOpacity ? "0.6",
  Font ? "Noto Sans",
  FontSize ? "",
  Locale ? "en_US.UTF-8",
  HeaderText ? "Welcome!",
}:
stdenvNoCC.mkDerivation rec {
  pname = "sddm-sugar-candy";
  version = "2024-07-07";

  src = fetchFromGitHub {
    owner = "Kangie";
    repo = "sddm-sugar-candy";
    rev = "d31dbf58286ecdcd3a490cd0c9d9ba2f15c26920";
    sha256 = "HMlzUyRvXvzjaeq4FDxsHZga1zsn1w2Ln7SpctqjWk8=";
  };

  dontWrapQtApps = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/sddm/themes
    cp -r $src $out/share/sddm/themes/sugar-candy

    configFile=$out/share/sddm/themes/sugar-candy/theme.conf

    ${lib.optionalString (background != null) ''
      substituteInPlace $configFile \
        --replace-fail 'Background="Backgrounds/Mountain.jpg"' 'Background="${background}"'
    ''}

    substituteInPlace $configFile \
      --replace-fail 'ScreenWidth="1440"' 'ScreenWidth="${ScreenWidth}"' \
      --replace-fail 'ScreenHeight="900"' 'ScreenHeight="${ScreenHeight}"' \
      --replace-fail 'FormPosition="left"' 'FormPosition="${FormPosition}"' \
      --replace-fail 'InterfaceShadowOpacity="0.6"' 'InterfaceShadowOpacity="${InterfaceShadowOpacity}"' \
      --replace-fail 'Font="Noto Sans"' 'Font="${Font}"' \
      --replace-fail 'FontSize=""' 'FontSize=${FontSize}' \
      --replace-fail 'Locale=""' 'Locale="${Locale}"' \
      --replace-fail 'HeaderText="Welcome!"' 'HeaderText="${HeaderText}"'

    runHook postInstall
  '';

  meta = {
    description = "The sweetest login theme available for the SDDM display manager";
    homepage = "https://github.com/${src.owner}/${src.repo}";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.linux;
  };
}
