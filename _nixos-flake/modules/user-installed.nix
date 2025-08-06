{ config, pkgs, ...}:

{
  # Install user packages
  environment.systemPackages = with pkgs; [
    brave
    neovim
    git
    p7zip
    xarchiver
    discord
    signal-desktop
    obsidian
    archipelago
    htop
    gcc
    ripgrep
    qpwgraph
    nextcloud-client
    spotify
    opensc # Yubikey
    streamcontroller
    chatterino7
    vlc
    wine
    wine64
    winetricks
  ];

  virtualisation.docker.enable = true;

  programs = {
    zsh = {
      enable = true;
      ohMyZsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [
          "git"
          "history"
          "docker"
        ];
      };
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.soren = {
    isNormalUser = true;
    description = "Soren";
    extraGroups = [ "networkmanager" "wheel" "docker" "input" "libvirtd" ];
    useDefaultShell = true;
    packages = with pkgs; [];
  };

  # set default shell
  users.defaultUserShell = pkgs.zsh; 

  # AppImages
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  # Yubikey
  services.pcscd.enable = true;
  programs.ssh.extraConfig = ''
    PKCS11Provider ${pkgs.opensc}/lib/pkcs11/opensc-pkcs11.so
  '';

  # Gnome keyring, needed for nextcloud and brave
  services.gnome.gnome-keyring.enable = true;
  
  programs.bash.shellAliases = {
    vi = "nvim";
    vim = "nvim";
  };

  services.flatpak.enable = true;

}
