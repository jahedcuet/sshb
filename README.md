# sshb - SSH Bookmark Manager

A terminal-based SSH connection manager with bookmarks, auto-negotiation for legacy devices, and GPG-encrypted password storage.

## Features

- **Bookmark Manager** - Save SSH connections with groups, credentials, and options
- **Auto-Negotiation** - Automatically detects and handles legacy SSH algorithms
- **Legacy Device Support** - Uses OpenSSH 6.7 for devices requiring deprecated algorithms (ssh-dss, ssh-rsa, diffie-hellman-group1-sha1)
- **Smart Search** - Fuzzy search with preview panel (fzf-based)
- **Password Encryption** - GPG-encrypted passwords protected by master password
- **OS Keyring** - Stores master password in GNOME Keyring/KDE Wallet (no plaintext)
- **TUI Interface** - Whiptail/dialog-based menu system
- **Auto-Install** - Automatically installs missing dependencies

## Requirements

- Linux (Debian/Ubuntu, RHEL/CentOS, Arch)
- bash 4.0+

## Dependencies (auto-installed)

- `fzf` - Fuzzy finder
- `sshpass` - SSH password authentication
- `gnupg` - Password encryption
- `whiptail` or `dialog` - TUI interface
- `libsecret-tools` - OS keyring integration
- `ssh6` - Legacy SSH client (auto-installed via ssh6-installer)

## Installation

### Quick Install

```bash
git clone https://github.com/jahedcuet/sshb.git
cd sshb
sudo ./install.sh
```

### Manual Install

```bash
sudo cp sshb /usr/local/bin/sshb
sudo chmod +x /usr/local/bin/sshb
```

### First Run

```bash
sshb
```

On first run, dependencies are auto-installed. You'll be prompted to set a master password.

## Usage

### TUI Mode (default)

```bash
sshb
```

Opens the whiptail/dialog menu interface.

### CLI Commands

| Command | Description |
|---------|-------------|
| `sshb` | Open TUI menu |
| `sshb connect` | FZF-based connection picker |
| `sshb search` | Smart search with preview |
| `sshb add` | Add new bookmark |
| `sshb edit <name>` | Edit bookmark |
| `sshb del <name>` | Delete bookmark |
| `sshb list` | List all bookmarks |
| `sshb logout` | Clear cached master password |

### Search Controls

| Key | Action |
|-----|--------|
| `Enter` | Connect |
| `Ctrl-E` | Edit bookmark |
| `Ctrl-D` | Delete bookmark |

## Bookmark Format

Bookmarks are stored in `~/.sshb/bookmarks.conf`:

```
group|name|host|port|user|auth|secret|legacy
```

Example:
```
OLT|Nandankanon-OLT1|10.0.12.2|22|isadmin|pass|encrypted_data|yes
Core|R1-core|192.168.1.1|22|admin|key|/home/user/.ssh/id_rsa|no
```

### Legacy Flag

- `no` - Auto-negotiate (modern SSH → legacy flags → ssh6 fallback)
- `yes` - Skip probing, use ssh6 directly (for known legacy devices)

## How Auto-Negotiation Works

1. **Probe** - Try modern SSH client
2. **Detect** - If legacy crypto error found, try with legacy algorithm flags
3. **Fallback** - If modern SSH can't handle algorithms (OpenSSH 9.8+), use ssh6

### Supported Legacy Algorithms

- **Key Exchange**: diffie-hellman-group1-sha1, diffie-hellman-group14-sha1
- **Host Key**: ssh-dss, ssh-rsa
- **Ciphers**: aes128-cbc, 3des-cbc, aes192-cbc, aes256-cbc
- **MACs**: hmac-md5, hmac-sha1, hmac-sha1-96

## Password Security

- Passwords encrypted with AES-256 via GPG
- Master password stored in OS keyring (GNOME Keyring/KDE Wallet)
- No plaintext storage anywhere
- Cache clears on logout (`sshb logout`) or reboot

## Directory Structure

```
~/.sshb/
├── bookmarks.conf    # Encrypted bookmarks
├── .verifier         # Master password verifier
├── ssh6_config       # Isolated ssh6 configuration
```

## License

MIT License
