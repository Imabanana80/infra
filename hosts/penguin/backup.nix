{ config, lib, pkgs, ... }:
let
    excludes = import ../../lib/exclude.nix;
    home = "/home/banana";
in
{
    environment.systemPackages = with pkgs; [
        borgbackup
    ];

    services.borgbackup.jobs.banana-home = {
        paths = "${home}";
        repo = "ssh://cdxh0c4w@cdxh0c4w.repo.borgbase.com/./repo";
        exclude = excludes.mapExcludes home;
        doInit = true;
        encryption = {
            mode = "repokey-blake2";
            passCommand = "cat ${home}/backup.key";
        };
        environment = {
            BORG_RSH = "ssh -i ${home}/.ssh/backup_ed25519";
        };
        extraCreateArgs = "--verbose --stats --checkpoint-interval 600";
        compression = "auto,zstd";
        startAt = "hourly";
    };
}
