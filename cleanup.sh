#!/bin/bash

# This script runs nix-store --gc to perform garbage collection

echo "Starting Nix garbage collection..."
nix-store --gc
nix-collect-garbage -d
echo "Nix garbage collection completed."

# Add any additional commands or logic needed after garbage collection here
