{ config, pkgs, lib, ... }:
{
  programs.firefox = {
    enable = true;
    policies = {
      disablepocket = true;
      extensionsettings = {
        "ublock0@raymondhill.net" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        # "keepassxc-browser@keepassxc.org" = {
        #   install_url =
        #     "https://addons.mozilla.org/firefox/downloads/latest/keepassxc-browser/latest.xpi";
        #   installation_mode = "force_installed";
        # };
        # easily get the extension id
        "queryamoid@kaply.com" = {
          install_url =
            "https://github.com/mkaply/queryamoid/releases/download/v0.2/query_amo_addon_id-0.2-fx.xpi";
          installation_mode = "force_installed";
        };
        "jid1-MnnxcxisBPnSXQ@jetpack" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
          installation_mode = "force_installed";
        };
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
    preferences = {
      "browser.startup.page" = 3; # resume
    };
  };
}

    
