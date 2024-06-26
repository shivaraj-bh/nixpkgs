{ lib
, attrs
, buildPythonPackage
, fetchFromGitHub
, hatch-vcs
, hatchling
, jsonschema
, pytest-subtests
, pytestCheckHook
, pythonOlder
, rpds-py
}:


let
  self = buildPythonPackage rec {
    pname = "referencing";
    version = "0.33.0";
    format = "pyproject";

    disabled = pythonOlder "3.7";

    src = fetchFromGitHub {
      owner = "python-jsonschema";
      repo = "referencing";
      rev = "refs/tags/v${version}";
      fetchSubmodules = true;
      hash = "sha256-QP/F6UNiKHGNMhGphDJgEFZnpGU5izExcI/A9WJjA5Q=";
    };

    nativeBuildInputs = [
      hatch-vcs
      hatchling
    ];

    propagatedBuildInputs = [
      attrs
      rpds-py
    ];

    nativeCheckInputs = [
      jsonschema
      pytest-subtests
      pytestCheckHook
    ];

    # avoid infinite recursion with jsonschema
    doCheck = false;

    passthru.tests.referencing = self.overridePythonAttrs { doCheck = true; };

    pythonImportsCheck = [
      "referencing"
    ];

    meta = with lib; {
      description = "Cross-specification JSON referencing";
      homepage = "https://github.com/python-jsonschema/referencing";
      changelog = "https://github.com/python-jsonschema/referencing/blob/${version}/CHANGELOG.rst";
      license = licenses.mit;
      maintainers = with maintainers; [ fab ];
    };
  };
in
  self
