{
  lib,
  fetchFromGitHub,
  rustPlatform,
  pkg-config,
  openssl,
  testers,
  avml,
  nix-update-script,
}:

rustPlatform.buildRustPackage rec {
  pname = "avml";
  version = "0.14.0";

  src = fetchFromGitHub {
    owner = "microsoft";
    repo = "avml";
    tag = "v${version}";
    hash = "sha256-MIqQ5NRWAfXm7AblsKCrUiaYN5IGUo2jWJMJZL+w3V4=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-husTembzDsqjI617spK6aj2de+NaajKCNYDiV2Fd6XQ=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ];

  env = {
    OPENSSL_NO_VENDOR = true;
  };

  passthru.tests.version = testers.testVersion { package = avml; };

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "A portable volatile memory acquisition tool for Linux";
    homepage = "https://github.com/microsoft/avml";
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.lesuisse ];
    platforms = lib.platforms.linux;
    mainProgram = "avml";
  };
}
