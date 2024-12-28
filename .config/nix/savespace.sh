podman container prune 
podman image prune -a --external
sudo nix-collect-garbage -d
sudo nix-collect-garbage
nix-store --optimise
