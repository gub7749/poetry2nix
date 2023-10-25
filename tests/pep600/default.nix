{ poetry2nix, python38, runCommand }:
let
  env = poetry2nix.mkPoetryEnv {
    python = python38;
    preferWheels = true;
    pyproject = ./pyproject.toml;
    poetrylock = ./poetry.lock;
    overrides = poetry2nix.overrides.withDefaults (_: super: {
      threadpoolctl = super.threadpoolctl.overridePythonAttrs (_: {
        format = "wheel";
      });
    });
  };
in
runCommand "pep600-test"
{ } ''
  ${env}/bin/python -c 'import open3d; print(open3d.__version__)'
  touch $out
''
