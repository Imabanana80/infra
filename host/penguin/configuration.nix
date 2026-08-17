{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./backup.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "penguin";

  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Singapore";
  
  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    windowManager.qtile.enable = true;
  };
  services.displayManager.ly.enable = true;

  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    user = "banana";
    dataDir = "/home/banana";
  };
    
  users.users.banana = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; 
    packages = with pkgs; [
      tree
    ];
  };

  programs.fish.enable = true;
  programs.niri.enable = true;

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.trace "warning: allowing unfree package ${pkgs.lib.getName pkg}" true;

  programs.steam = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    vim     
    btop
    git
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  virtualisation.docker = {
    enable = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  system.stateVersion = "26.05";
}

