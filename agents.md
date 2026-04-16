# Agent Context

This is daniel's nix configuration repo. It manages 4 systems from a single flake.

## Machines

| Name | Type | OS | Flake target |
|------|------|----|-------------|
| coruscant | macOS desktop | aarch64-darwin | `darwinConfigurations.coruscant` |
| kashyyk | macOS laptop | aarch64-darwin | `darwinConfigurations.kashyyk` |
| mars (on coruscant) | OrbStack NixOS VM | aarch64-linux | `nixosConfigurations.mars-coruscant` |
| mars (on kashyyk) | OrbStack NixOS VM | aarch64-linux | `nixosConfigurations.mars-kashyyk` |

Each macOS host has its own OrbStack VM named "mars". The VMs are identical except for signing keys.

## Flake Inputs

- **nixpkgs**: unstable (shared across all 4 configs)
- **nix-darwin**: macOS system config
- **home-manager**: user-level config (dotfiles, packages, shell)
- **nix-homebrew**: homebrew cask management on macOS

## File Layout

```
flake.nix                          # all 4 system configs
hosts/
  common.nix                       # shared darwin system settings
  coruscant.nix, kashyyk.nix       # per-host darwin (just hostname + imports)
  homebrew.nix                     # homebrew casks (darwin only)
  mars.nix                         # shared NixOS VM config (user, zsh, nix-ld, networking)
  orbstack.nix                     # OrbStack platform integration (DO NOT DELETE — see below)
home/
  macos.nix                        # home-manager for darwin
  mars.nix                         # home-manager for NixOS VMs
dotfiles/
  git.nix                          # shared git config (supports key:: signing format)
  zsh.nix                          # macOS zsh (antidote, homebrew)
  zsh-mars.nix                     # VM zsh (rebuild alias, warpify hook)
  ssh.nix                          # macOS SSH config (Secretive agent)
  jj.toml                          # shared jj config
  jj-signing-coruscant.toml        # coruscant's signing key
  jj-signing-kashyyk.toml          # kashyyk's signing key
  zed_settings.json                # reference copy (NOT managed by home-manager)
  zed_keymap.json                  # managed by home-manager
  zed_theme.json                   # managed by home-manager
```

## SSH Key Signing

Uses **Secretive** (macOS SSH key manager) on both hosts. Each host has a unique ECDSA key.

- **macOS**: `gitSigningKey` points to the .pub file in Secretive's container
- **NixOS VMs**: `gitSigningKey` uses `key::` prefix format (e.g. `key::ecdsa-sha2-nistp256 AAAA...`) because the .pub file doesn't exist in the VM — the private key is available via OrbStack's automatic SSH agent forwarding
- **jj**: signing config is per-host toml files, `behavior = "drop"` means sign only on push

The `git.nix` module conditionally enables signing when `gitSigningKey` is non-null.

## OrbStack VM Details

- VMs run NixOS inside OrbStack (lightweight Linux VM for macOS)
- `hosts/orbstack.nix` is critical — it handles OrbStack CLI PATH, DNS, disables sshd (OrbStack has its own), systemd watchdog fixes, SSH agent forwarding config, and the orbstack user group. Without it the VM breaks.
- The macOS repo at `~/.config/nix` is accessible inside the VM at `/mnt/mac/Users/daniel/.config/nix`
- Rebuilds run from the VM pointing at `/mnt/mac/...` — no need to clone the repo into the VM
- The `rebuild` alias in `zsh-mars.nix` uses `configName` (passed via `extraSpecialArgs`) to target the correct flake config
- User `daniel` has UID 501 (matches macOS) with `isSystemUser = true` as a workaround for fixed UID assignment
- `users.mutableUsers = true` preserves the password set during `orb create --set-password`
- `nix-ld` is enabled for dynamically linked binaries (Zed downloads node.js for language servers)
- `programs.zsh.enable = true` at system level adds zsh to /etc/shells; home-manager configures it

## Zed Editor

- `settings.json` is NOT managed by home-manager — Zed needs to write to it (ssh_connections for remote dev)
- `keymap.json` and theme ARE managed by home-manager (read-only is fine)
- Zed remote dev to the VM works via `ssh orb` — the remote server binary is statically linked and auto-downloads
- `nix-ld` is the safety net for any dynamically linked binaries Zed downloads inside the VM

## Rebuilding

- **macOS**: `rebuild` alias (or `sudo darwin-rebuild switch --flake ~/.config/nix`)
- **NixOS VM**: `rebuild` alias inside VM (or `sudo nixos-rebuild switch --flake /mnt/mac/Users/daniel/.config/nix#mars-coruscant`)
- **From macOS to VM**: `ssh -t orb 'sudo nixos-rebuild switch --flake /mnt/mac/Users/daniel/.config/nix#mars-coruscant'`

## Traps

1. **Nix flakes only see git-tracked files.** Any new/renamed .nix file MUST be `git add`-ed before rebuild or you get `error: path does not exist`. The rebuild may appear to succeed but silently use stale config.
2. **First VM rebuild needs**: `--option extra-experimental-features "nix-command flakes"` (NOT `--extra-experimental-features` which is a nix CLI flag, not nixos-rebuild).
3. **`ssh orb` vs `ssh -t orb`**: sudo requires a TTY. Use `-t` when running sudo commands from macOS.
4. **Tools missing after rebuild**: the SSH session keeps the old shell environment. Log out and back in.
5. **OrbStack root CA cert**: not included in `orbstack.nix` because it's per-installation. If TLS errors arise for OrbStack-internal services, copy the cert from `/etc/nixos/orbstack.nix` on a fresh VM.
6. **Per-repo dev tools**: use `nix develop` with project-level flakes + direnv (already configured in `home/mars.nix`). Global tools are in `home.packages`.
