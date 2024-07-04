{
  enable = true;
  policies = {
    DisablePocket = true;
    ExtensionSettings = {
      "uBlock0@raymondhill.net" = {
        install_url =
          "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        installation_mode = "force_installed";
      };
      "keepassxc-browser@keepassxc.org" = {
        install_url =
          "https://addons.mozilla.org/firefox/downloads/latest/keepassxc-browser/latest.xpi";
        installation_mode = "force_installed";
      };
      # easily get the extension id
      "queryamoid@kaply.com" = {
        install_url =
          "https://github.com/mkaply/queryamoid/releases/download/v0.2/query_amo_addon_id-0.2-fx.xpi";
        installation_mode = "force_installed";
      };
    };
  };
  preferences = {
    "browser.startup.page" = 3; # resume
  };
}
