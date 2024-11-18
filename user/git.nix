{config, ...}: {
  # Configure Git
  programs.git = {
    enable = true;
    userName = "jtawari";
    userEmail = "jtawari.me@gmail.com";
    extraConfig = {
      gpg.format = "ssh";
      commit.gpgsign = true;
      user.signingkey = "${config.home.homeDirectory}/.ssh/jtawari.pub";
      init.defaultBranch = "master";
      push.autoSetupRemote = true;
    };
  };
}
