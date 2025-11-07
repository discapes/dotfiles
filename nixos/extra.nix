{ config, pkgs, ... }:
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # for podman:
  # Enable common container config files in /etc/containers
  # virtualisation.containers.enable = true;
  # virtualisation = {
  #   podman = {
  #     enable = true;
  #     # Create a `docker` alias for podman, to use it as a drop-in replacement
  #     dockerCompat = true;
  #     # Required for containers under podman-compose to be able to talk to each other.
  #     defaultNetwork.settings.dns_enabled = true;
  #     # dockerSocket.enable = true;
  #   };
  # };

  # for docker:
  # we use docker since podman doesn't work with a remote DOCKER_HOST
  virtualisation.docker = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    docker-compose
    wget
    vim
    git
    bitwarden-desktop
    gnome-software
    kitty
    yazi
    zoxide
    fastfetch
    just
    tmux
    gnupg
    fzf
    fd
    ripgrep
    dust
    ffmpeg
    bat
    lsd
    tldr
    direnv
    jq
    yq-go
    resvg # integrates with yazi, like some others here
    imagemagick
    lazygit
    ncdu
    dwt1-shell-color-scripts
    lolcat
    nixfmt-rfc-style
    chezmoi
    wl-clipboard
    clang # needed for treesitter
    tree-sitter
    python3
    file
    lshw
    openssl
    zip
    unzip
    nodejs_latest
    ansible
    gnome-tweaks
    rage
    wireguard-tools
    gnome-extension-manager
    libreoffice-qt6-fresh
    cargo # for mason to install nil_ls
    statix
  ];

  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  services.xserver.excludePackages = [ pkgs.xterm ];
  environment.gnome.excludePackages = (
    with pkgs;
    [
      gnome-tour
      yelp # help
      epiphany # browser
    ]
  );

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };
  programs.zsh.enable = true;
  programs.zsh.enableGlobalCompInit = false; # we do the compinit ourselves
  users.users.me = {
    shell = pkgs.zsh;
  };
  security.sudo.wheelNeedsPassword = false;
  security.pam.services.passwd.nodelay = true;
  environment.localBinInPath = true;

  programs.gnupg.agent.enable = true;

  networking.nameservers = [
    "1.1.1.1"
    "9.9.9.9"
  ];
}
