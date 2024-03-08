{ pkgs, lig, configs, ... }:

let custom-curl = pkgs.curl.override {
  #sslSupport = true;
  scpSupport = false;
  gnutlsSupport = false;
  opensslSupport = true;
};

in 
{
  environment.systemPackages = with pkgs; [
    custom-curl
    openssl
  ];

  environment.sessionVariables = rec {
    CURL_CA_BUNDLE = "/etc/ssl/certs/ca-certificates.crt";
  };

  environment.variables = rec {
    CURL_CA_BUNDLE = "/etc/ssl/certs/ca-certificates.crt";
  };
  #programs.curl = {
  #  enable = true;
  #  sslSupport = true;
  #  #ca-bundle = "/etc/ssl/certs/ca-bundlr.crt";
  #};

  #environment.systemPackages = with pkgs; [
  #  curl
  #];

  #environment.systemPackages = with pkgs; [
  #  #curl
  #  (pkgs.curl.override { sslSupport = true # "/etc/ssl/certs/ca-bundle.crt"; 
  #  })
  #  #(curl.override { ca-bundle = "/etc/ssl/certs/ca-bundle.crt"; })
  #];
}
