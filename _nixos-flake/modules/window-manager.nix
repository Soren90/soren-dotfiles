{ config, pkgs, ...}:

{
  # Enable Wayland support
  programs = { 
    hyprland = {
      enable = true;
      withUWSM = true; 
      xwayland.enable = true;
    };
    hyprlock.enable = true;
    thunar.enable = true;
    thunar.plugins = with pkgs.xfce; [
      exo
      thunar-archive-plugin
      thunar-volman
      tumbler
      ristretto # Photoviewer
    ];
  };

  # Install necessary packages
  environment.systemPackages = with pkgs; [
    hyprland # Window manager
    hyprpaper # Wallpaper
    hyprshot # Screenshot
    hypridle # Hibernation
    hyprcursor # unified curser themes
    waybar # Navigation bar
    wofi # Application launcher
    swaynotificationcenter
    nwg-look # GTK Styling
    wl-clipboard # Copy paste daemon
    polkit_gnome
    xdg-desktop-portal-hyprland # Enables screensharing
    kitty # Terminal
    zsh # Bash replacement
    nwg-bar # Needed for waybar power button
    pavucontrol # Sound control
    networkmanagerapplet # Needed for waybar
    adwaita-icon-theme # Needed for waybar icons
    brightnessctl # needed for adjusting brightness in waybar
    pulseaudio # needed for waybar volume control
    yad # Diaglog manager for waybar calendar
    stow # dotfile manager
    pkgs.catppuccin-sddm
  ];


  # This is needed for waybar volume control  
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  # Enable seatd for input devices
  services.seatd.enable = true;

  # Set XDG_RUNTIME_DIR for wayland
  environment.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
  };

  # Login manager
  services.displayManager.sddm.wayland.enable = true;

  services.displayManager.sddm = {
    enable = true;
    theme = "catppuccin-mocha";
    package = pkgs.kdePackages.sddm;
  };

  # Waybar font
  fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono nerd-fonts.meslo-lg ubuntu_font_family ];

}
