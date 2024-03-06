#!/bin/sh

# add the unstable channel so we can include it in configs for simple dependencies
nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
nix-channel --update

