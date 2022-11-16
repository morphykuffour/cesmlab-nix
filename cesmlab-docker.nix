# source: https://github.com/matilde-ametrine/nixfiles/blob/b833073fe9279b3199481161ab4f2e84f680fda6/packages/cesm-lab.nix
{
  config,
  pkgs,
  ...
}:
with pkgs; let
  image = dockerTools.pullImage {
    imageName = "escomp/cesm-lab-2.2";
    finalImageTag = "latest";

    imageDigest = "sha256:8ba7cc2abed7201955e067274de906faee974f1f24a03730fbd17cba8cbf6e7c";
    sha256 = "17rfvxykb3p8qsjd4r58zirk238qv8fwyrcklkc55x1m08afjq3p";
  };
in {
  virtualisation.docker.enable = true;

  systemd.services.cesm-lab = {
    description = "CESM2.2 lab";

    script = ''
      ${docker}/bin/docker load < ${image}

      mkdir -p /tmp/cesm-lab

      exec ${docker}/bin/docker run -p 8888:8888 --rm \
        -v /data/3.software/3.cesm-lab:/home/user -v /tmp/cesm-lab:/tmp \
        ${image.imageName}
    '';

    after = ["docker.service" "network-online.target"];
    wantedBy = ["multi-user.target"];

    serviceConfig.User = "matilde";
  };

  users.users.matilde.extraGroups = ["docker"];
}
