{
    pkgs,
    zen-browser,
    config,
    ...
}: {
    imports = [
        zen-browser.homeModules.twilight
    ];
    programs.zen-browser = {
        enable = true;
        setAsDefaultBrowser = true;
    };
    programs.zen-browser.policies = {
        AutofillAddressEnabled = false;
        AutofillCreditCardEnabled = false;
        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        DisableFormHistory = true;
        SanitizeOnShutdown = {
            History = true;
            FormData = true;
        };
        EnableTrackingProtection = {
            Value = true;
            Locked = true;
            Cryptomining = true;
            Fingerprinting = true;
        };
        SearchEngines = {
            Default = "Kagi";
        };
        ExtensionSettings = {
            "search@kagi.com" = {
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/kagi-search-for-firefox/latest.xpi";
                installation_mode = "force_installed";
            };
            "uBlock0@raymondhill.net" = {
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
                installation_mode = "force_installed";
            };
            "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
                installation_mode = "force_installed";
            };

        };
    };
}
