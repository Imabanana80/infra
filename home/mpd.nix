{
    config,
    pkgs,
    inputs,
    ...
}: 
{
    services.mpd = {
        enable = true;
        musicDirectory = "/home/banana/music/";
        playlistDirectory = "/home/banana/music/playlists";
        extraConfig = ''
            auto_update "yes"
            audio_output {
                type "pipewire"
                name "pipewire"
            }
        '';
    };
    home.packages = with pkgs; [
        mpc
    ];

}
