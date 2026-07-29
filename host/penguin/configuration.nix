{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
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
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
  programs.niri.enable = true;
  programs.firefox.enable = true;

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
    "steam"
    "steam-unwrapped"
    "obsidian"
  ];
  programs.steam = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    vim     
    wget
    git
    ghostty
    obsidian
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

