{
    pkgs,
    config,
    ...
}: {
    programs.swaylock = {
        enable = true;
        settings = {
            image = "/home/banana/infra/wallpaper/BlueNBeautiful.png";
            color = "1e1e2e";
            font="JetBrainsMono Nerd Font";
            font-size = 24;
            indicator-idle-visible = false;
            indicator-radius = 100;
            indicator-thickness = 7;
            line-color = "1e1e2e";
            ring-color = "89b4fa";
            key-hl-color = "a6e3a1";
            inside-color = "1e1e2e";
            separator-color = "00000000";
        };
    };
}
