{ config, lib, pkgs, ... }:
let
    common = import ../backups.nix;
in
{
    environment.systemPackages = with pkgs; [
        borgbackup
    ];

    services.borgbackup.jobs.banana-home = {
        paths = "/home/banana";
        repo = "ssh://cdxh0c4w@cdxh0c4w.repo.borgbase.com/./repo";
        exclude = common.mapExcludes "/home/banana";
        doInit = true;
        encryption = {
            mode = "repokey-blake2";
            passCommand = "cat /home/banana/backup.key";
        };
        environment = {
            BORG_RSH = "ssh -i /home/banana/.ssh/backup_ed25519";
        };
        extraCreateArgs = "--verbose --stats --checkpoint-interval 600";
        compression = "auto,zstd";
        startAt = "hourly";
    };
}
