{ config, pkgs, fetchFromGithub, lib, ... }: {
  nixpkgs.overlays = [
    (final: prev: {
      # the latest release, 5.1, is from 2020, and the -P argument was added in 2021 to the main branch
      brightnessctl = prev.brightnessctl.overrideAttrs (old: {
        src = pkgs.fetchFromGitHub {
          rev = "3152968fee82796e5d3bac3b49d81e1dd9787850";
          owner = "Hummer12007";
          repo = "brightnessctl";
          hash = "sha256-zDohA3F+zX9xbS0SGpF0cygPRPN6iXcH1TrRMhoO1qs=";
        };
      });
      libratbag = prev.libratbag.overrideAttrs (old: {
        src = pkgs.fetchFromGitHub {
          rev = "df3c73e95841273908410ed1c563d8ed4ec21edd";
          owner = "libratbag";
          repo = "libratbag";
          hash = "sha256-hI6Xu1RtyJsNga7BaMjQixnyv/V5qkp75FAFcqrvaHE=";
        };
      });
      # we need to add glib-networking so screenshots can be downloaded
      gnome = prev.gnome.overrideScope (final: prev: {
        gnome-software = prev.gnome-software.overrideAttrs
          (old: { buildInputs = old.buildInputs ++ [ pkgs.glib-networking ]; });
      });
    })
  ];
}
