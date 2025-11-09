{ config, lib, pkgs, ...}:

{
  hardware.opengl = {
    enable = true;
#    driSupport = true;
#    driSupport32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  environment.systemPackages = with pkgs; [
    nvtopPackages.nvidia
    #nvtop
    #cudaPackages.cudatoolkit
    #cudaPackages.cudnn
    #cudaPackages.cutensor
    #linuxPackages.nvidia_x11
  ];

  boot.initrd.kernelModules = [ "nvidia" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];

  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    #package = config.boot.kernelPackages.nvidiaPackages.production.overrideAttrs {
    #    version = "580.76.05";
    #    src = pkgs.fetchurl {
    #      url = "https://us.download.nvidia.com/XFree86/Linux-x86_64/580.76.05/NVIDIA-Linux-x86_64-580.76.05.run";
    #      sha256 = "1zcpbp859h5whym0r54a3xrkqdl7z3py1hg8n8hv0c89nqvfd6r1";
    #    };
    #  };
  };

  hardware.nvidia-container-toolkit.enable = true;


}
