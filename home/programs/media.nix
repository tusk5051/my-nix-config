{
  pkgs,
  config,
  ...
}:
# media - media players and creation
{
  programs = {
    mpv = {
      enable = true;
      defaultProfiles = ["gpu-hq"];
      scripts = [pkgs.mpvScripts.mpris];
    };

    obs-studio.enable = true;
  };
}
