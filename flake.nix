{
  description = "Playwright development environment for NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    devShells.${system}.default = pkgs.mkShell {
      nativeBuildInputs = with pkgs; [
        nodejs_24
        playwright-driver.browsers
        playwright-test
      ];

      shellHook = ''
        export PLAYWRIGHT_BROWSERS_PATH=${pkgs.playwright-driver.browsers}
        export PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS=true

        echo "Playwright environment activated"
        echo "Node.js version: $(node --version)"
        echo "Playwright version: $(playwright --version)"
        echo "Playwright browsers: $PLAYWRIGHT_BROWSERS_PATH"
        echo ""
        echo "Ready to use Playwright!"
      '';
    };

    apps.${system}.default = {
      type = "app";
      program = "${pkgs.writeShellScript "playwright-wrapper" ''
        export PLAYWRIGHT_BROWSERS_PATH=${pkgs.playwright-driver.browsers}
        export PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS=true
        exec ${pkgs.playwright-test}/bin/playwright "$@"
      ''}";
    };
  };
}
