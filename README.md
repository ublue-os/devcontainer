# Universal Blue Devcontainers

[![build](https://github.com/ublue-os/devcontainer/actions/workflows/build.yml/badge.svg)](https://github.com/ublue-os/devcontainer/actions/workflows/build.yml)

This repository provides specialized development containers for [Universal Blue](https://universal-blue.org/) projects. These containers include all the necessary tools, dependencies, and configurations needed for developing, building, and working with Universal Blue images and ISO distributions.

## Available Containers

### 🛠️ Base Container (`ghcr.io/ublue-os/devcontainer:latest`)

A comprehensive development environment for Universal Blue projects, built on Fedora with all essential tools pre-installed.

**Use Cases:**
- Developing Universal Blue images and configurations
- Building OCI container images with proper signing
- Working with rpm-ostree and bootc systems
- Container development with Podman/Buildah
- Shell scripting and automation

**Key Tools Included:**
- **Container Tools**: Podman, Buildah, Skopeo, Podman Machine
- **Universal Blue Tools**: 
  - `ublue-os-signing` - Universal Blue signing utilities
  - `bootc-base-imagectl` - Bootc image management
  - `rpm-ostree` - Atomic host management
- **Security & Signing**: 
  - `cosign` - Container image signing
  - `syft` - Software Bill of Materials generation
  - `sbsigntools` - Secure Boot signing
- **Build Tools**: 
  - `just` - Command runner (justfile support)
  - `golang-oras` - OCI registry client
  - `yq` - YAML/JSON processor
- **System Tools**: 
  - `macadam` - Container machine management
  - `erofs-utils`, `zstd` - Filesystem utilities
  - `tmux`, `ShellCheck`, `shfmt` - Development utilities

**VSCode Extensions:**
- GitHub Actions support
- GitHub Pull Request integration
- systemd syntax support
- Bash IDE with advanced shell scripting support
- Justfile syntax highlighting

### 🏗️ Titanoboa Container (`ghcr.io/ublue-os/devcontainer:titanoboa`)

Specialized container for building [Titanoboa](https://github.com/ublue-os/titanoboa) bootable ISOs, extending the base container with ISO creation tools.

**Use Cases:**
- Building Titanoboa installer ISOs
- Creating custom Universal Blue installer images
- UEFI/BIOS bootable media development
- Live system development

**Additional Tools (beyond base container):**
- **ISO Creation**: `xorriso` - ISO 9660 filesystem creation
- **Filesystem Tools**: 
  - `squashfs-tools` - Compressed filesystem creation
  - `dosfstools` - FAT filesystem utilities
- **Boot Management**: 
  - `grub2` + modules - GRUB bootloader (x86_64/aarch64)
  - `shim` - UEFI Secure Boot support

**⚠️ Important**: Titanoboa builds require **real root privileges** due to ISO creation and filesystem operations.

## Quick Start

### Using with VS Code Dev Containers

1. **For Universal Blue Development:**
   ```json
   {
     "image": "ghcr.io/ublue-os/devcontainer:latest"
   }
   ```

2. **For Titanoboa ISO Building:**
   ```json
   {
     "image": "ghcr.io/ublue-os/devcontainer:titanoboa",
     "privileged": true,
     "runArgs": ["--privileged"]
   }
   ```

### Using with Podman/Docker

```bash
# Base container for Universal Blue development
podman run -it --rm \
  -v $(pwd):/workspace \
  ghcr.io/ublue-os/devcontainer:latest

# Titanoboa container (requires privileged mode)
podman run -it --rm --privileged \
  -v $(pwd):/workspace \
  ghcr.io/ublue-os/devcontainer:titanoboa
```

### GitHub Codespaces

Click the "Code" button on any Universal Blue repository and select "Create codespace on main" to automatically use the appropriate devcontainer.

## Development Workflows

### Building Universal Blue Images

The base container includes all tools needed for the standard Universal Blue development workflow:

```bash
# Clone your Universal Blue image repository
git clone https://github.com/your-org/your-ublue-image
cd your-ublue-image

# Build using the included tools
just build
just sign
```

### Creating Titanoboa ISOs

Using the Titanoboa container for ISO creation:

```bash
# Clone Titanoboa
git clone https://github.com/ublue-os/titanoboa
cd titanoboa

# Build ISO (requires privileged container)
just build-iso
```

## Architecture Support

Both containers are built for multiple architectures:
- **x86_64** (Intel/AMD 64-bit)
- **aarch64** (ARM 64-bit)

The containers automatically detect the architecture and install appropriate tools (e.g., correct GRUB modules for the target platform).

## Container Features

### Security Configuration

- Images are signed with cosign using Universal Blue's signing infrastructure
- Secure Boot compatible tools included for creating signed bootable media
- SELinux policy targeted configuration included

### Development Experience

- Pre-configured with popular VS Code extensions for Universal Blue development
- Shell completion and syntax highlighting for all included tools
- Optimized for container-in-container workflows with proper Podman configuration

### User Configuration

- Default user: `ublue` (non-root for security)
- Proper rootless container support with subuid/subgid configuration
- XDG_RUNTIME_DIR properly configured for user services

## Contributing

This repository follows Universal Blue's development practices:

1. **Pull Requests**: All changes go through PR review
2. **Automated Building**: GitHub Actions automatically builds and publishes containers
3. **Security**: All images are signed and scanned for vulnerabilities
4. **Renovate**: Dependencies are automatically updated via Renovate

### Local Development

To modify and test these containers locally:

```bash
# Clone the repository
git clone https://github.com/ublue-os/devcontainer
cd devcontainer

# Build base container
cd src/base
podman build -t local/ublue-devcontainer:base .

# Build Titanoboa container
cd ../titanoboa
podman build -t local/ublue-devcontainer:titanoboa .
```

## Support

- **Documentation**: [Universal Blue Documentation](https://universal-blue.org/)
- **Community**: [Universal Blue Discord](https://discord.gg/universal-blue)
- **Issues**: Report issues in this repository's [issue tracker](https://github.com/ublue-os/devcontainer/issues)

## License

This project is part of the Universal Blue ecosystem. See individual component licenses for details.
