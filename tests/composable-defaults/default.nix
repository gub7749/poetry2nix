{ poetry2nix, python3 }:
let
  p2nix = poetry2nix.overrideScope' (_: super: {

    defaultPoetryOverrides = super.defaultPoetryOverrides.extend (_: _: {
      my-custom-pkg = super.my-custom-pkg.overridePythonAttrs (_: { });
    });

  });

in
p2nix.mkPoetryApplication {
  python = python3;
  projectDir = ./.;
  overrides = p2nix.overrides.withDefaults (_: super: {
    inherit (super) customjox;
  });
}
