{
  config,
  pkgs,
  user,
  lib,
  system,
  ...
}:

{
  # required by home-manager
  home.username = user;
  home.homeDirectory =
    if lib.strings.hasSuffix "darwin" system then "/Users/${user}" else "/home/${user}";
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # see packages.nix for a note on what packages belong where.
  home.packages =
    with pkgs;
    (
      let
        languageServers = [
          # Bash
          bash-language-server
          # Svelte
          svelte-language-server
          # Static Type Checker for Python
          pyright
          # Tailwind CSS
          tailwindcss-language-server
          # eslint, html, css, json
          vscode-langservers-extracted
          # Ansible
          ansible-language-server
          # Docker
          docker-compose-language-service
          dockerfile-language-server-nodejs
          # Harper spell checker
          harper
          # Markdown
          marksman
          # Nix
          nil
          # Prisma Schema
          # nix-shell -p 'nodePackages."@prisma/language-server"'
          # https://github.com/NixOS/nixos-search/issues/293
          # https://github.com/NixOS/nixpkgs/pull/392481
          # nodePackages."@prisma/language-server"
          # Python linter and code formatter
          ruff
          # TOML
          taplo
          # Terraform
          terraform-ls
          # LSP wrapper for typescript extension of vscode
          # replaces tsserver in LazyVim
          # https://github.com/LazyVim/LazyVim/discussions/3603
          # typescript-language-server
          vtsls
          # YAML
          yaml-language-server
          # Lua
          lua-language-server
        ];
        formatters = [
          djlint
          black
          xmlformat
          stylua
          nodePackages.prettier
          nixfmt-rfc-style
          shfmt
          markdownlint-cli2
        ];
        util = [
          fzf
          fd
          ripgrep
          dust
          ffmpeg
          imagemagick
          resvg
          _7zz
          bat
          zoxide
          dtrx
          fdupes
          gita
          lsd
          ps_mem
          tldr
          direnv
          jq
          yq
        ];
        tui = [
          yazi
          lazygit
          dive
          ncdu
          tmux
        ];
        fun = [
          fastfetch
          figlet
          lolcat
          dwt1-shell-color-scripts
        ];
        wireless = [
          gqrx
          gnuradio
          gpredict
          hackrf
          hcxdumptool
          hcxtools
          iw
        ];
        kube = [
          # argocd
          flux
          kubectl
          kubernetes-helm
          kustomize
          talosctl
        ];
        rust = [
          rustc
          rustfmt
          rust-analyzer
          clippy
          cargo
        ];
        others = [
          # SED_ADD_PKGS_HERE
    bitwarden-cli
    mpv
          just
          opentofu
          aria2
          bun
          cargo
          chezmoi
          eslint
          gnupg
          killall
          languagetool
          mitmproxy
          neovim
          nixd
          rustc
          sqlite
          uv
          yarn
          rclone
          # android-backup-extractor
          # apksigner
          # apktool
          # jre
          # vdhcoapp
        ];
      in
      languageServers
      ++ formatters
      ++ util
      ++ tui
      ++ fun
      # ++ wireless
      # ++ kube
      # ++ rust
      ++ others
    );

  # # It is sometimes useful to fine-tune packages, for example, by applying
  # # overrides. You can do that directly here, just don't forget the
  # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
  # # fonts?
  # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

  # # You can also create simple shell scripts directly inside your
  # # configuration. For example, this adds a command 'my-hello' to your
  # # environment:
  # (pkgs.writeShellScriptBin "my-hello" ''
  #   echo "Hello, ${config.home.username}!"
  # '')

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/user/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
