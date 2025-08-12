{ config, pkgs, ...}:

{

programs.virt-manager.enable = true;

users.groups.libvirtd.members = ["soren"];

virtualisation.libvirtd.enable = true;

virtualisation.spiceUSBRedirection.enable = true;

}
