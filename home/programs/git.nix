{
  pkgs,
  ...
}: {
  home.packages = [pkgs.gh];

  programs.git = {
    enable = true;
    userName = "Succoria";
    userEmail = "tusk5051@apsinbox.com";
  };
}
