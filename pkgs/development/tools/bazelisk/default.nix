{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "bazelisk";
  version = "1.10.0";

  src = fetchFromGitHub {
    owner = "bazelbuild";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-G2cHKhgsv1fj7eKbADER3R2uXp9DnKevboE7vnO5pDE=";
  };

  vendorSha256 = "sha256-5qpeAD4VFsR8iJlRiNTncOdq39lq3MU6gSLu3G/BcPU=";

  doCheck = false;

  buildFlagsArray = [ "-ldflags=-s -w -X main.BazeliskVersion=${version}" ];

  meta = with lib; {
    description = "A user-friendly launcher for Bazel";
    longDescription = ''
      BEWARE: This package does not work on NixOS.
    '';
    homepage = "https://github.com/bazelbuild/bazelisk";
    license = licenses.asl20;
    maintainers = with maintainers; [ elasticdog ];
  };
}
