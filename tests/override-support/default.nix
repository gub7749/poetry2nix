{ python3, poetry2nix, runCommand }:
let
  p = poetry2nix.mkPoetryApplication {
    python = python3;
    src = ./.;
    poetrylock = ./poetry.lock;
    pyproject = ./pyproject.toml;
    overrides = poetry2nix.overrides.withDefaults (
      _: super: {
        alembic = super.alembic.overridePythonAttrs (
          _: {
            TESTING_FOOBAR = 42;
          }
        );
      }
    );
  };
in
runCommand "test"
{ } ''
  x=${builtins.toString p.python.pkgs.alembic.TESTING_FOOBAR}
  [ "$x" = "42" ] || exit 1
  mkdir $out
''
