# Kali Linux Learning Lab

[![Platform](https://img.shields.io/badge/Host-Windows_10%2F11-0078D4?logo=windows11)](https://www.microsoft.com/windows)
[![VirtualBox](https://img.shields.io/badge/Hypervisor-Oracle_VirtualBox-183A61?logo=virtualbox)](https://www.virtualbox.org/)
[![Kali Linux](https://img.shields.io/badge/Guest-Kali_Linux-557C94?logo=kalilinux)](https://www.kali.org/)

Hands-on documentation for building Kali Linux skills through safe labs, tools, networking, scripts, CTF practice, and troubleshooting.

## Module 01 — Kali Linux on VirtualBox (Windows)

A beginner-friendly, screenshot-driven guide to installing Oracle VirtualBox and running the official prebuilt Kali Linux VirtualBox image on Windows. This method keeps Kali isolated from the host OS, supports snapshots, and avoids a full ISO installation.

For the real, privacy-reviewed installer screenshots, see the [manual ISO installation guide](docs/iso-install.md). The front page intentionally keeps the prebuilt-VM overview image-free.

> [!IMPORTANT]
> Use Kali Linux only on systems and networks you own or have explicit permission to test. Start with VirtualBox **NAT** networking. Do not use **Bridged Adapter** merely because a lab says “networking”—bridging places the VM directly on the local network.

## What this guide builds

```text
Windows host
└── Oracle VirtualBox
    └── Kali Linux VM (official prebuilt image)
        ├── 2 CPU cores
        ├── 2–4 GB RAM
        ├── NAT networking
        └── Clean snapshot after setup
```

## Requirements

- 64-bit Windows 10 or Windows 11
- Intel VT-x or AMD-V virtualization enabled in BIOS/UEFI
- At least 8 GB host RAM; 16 GB is more comfortable
- At least 25 GB of free disk space for the download, extraction, updates, and snapshots
- Administrator access to install VirtualBox
- A stable internet connection

Recommended VM allocation:

| Host computer | Kali RAM | Kali CPUs | Network |
| --- | ---: | ---: | --- |
| 8 GB RAM | 2 GB | 2 | NAT |
| 16 GB+ RAM | 4 GB | 2–4 | NAT |

Do not assign every CPU core or more than half of the host's RAM to the VM.

## Official links

| Resource | Link | Purpose |
| --- | --- | --- |
| Oracle VirtualBox downloads | [virtualbox.org/wiki/Downloads](https://www.virtualbox.org/wiki/Downloads) | Download the current Windows host installer |
| VirtualBox User Manual | [virtualbox.org/manual](https://www.virtualbox.org/manual/UserManual.html) | Official configuration reference |
| Kali downloads | [kali.org/get-kali](https://www.kali.org/get-kali/) | Download the official VirtualBox image |
| Kali prebuilt VM instructions | [Kali: Import Pre-Made VirtualBox VM](https://www.kali.org/docs/virtualization/import-premade-virtualbox/) | Official import workflow |
| Kali VirtualBox install guide | [Kali inside VirtualBox](https://www.kali.org/docs/virtualization/install-virtualbox-guest-vm/) | Manual ISO workflow and recommended settings |
| Kali image verification | [Verify an official Kali image](https://www.kali.org/docs/introduction/download-official-kali-linux-images/) | Check SHA256 before use |
| 7-Zip | [7-zip.org](https://www.7-zip.org/) | Extract the Kali `.7z` archive on Windows |
| Guest Additions repair | [Kali Guest Tools](https://www.kali.org/docs/virtualization/install-virtualbox-guest-additions/) | Fix display, mouse, and clipboard integration |

## Quick path: official prebuilt Kali VM

### 1. Confirm virtualization is enabled

Open **Task Manager → Performance → CPU**. Confirm that **Virtualization** says **Enabled**. If it is disabled, enable Intel Virtualization Technology/VT-x or AMD-V/SVM in BIOS/UEFI before continuing.

### 2. Download and install VirtualBox

1. Open the [official VirtualBox downloads page](https://www.virtualbox.org/wiki/Downloads).
2. Under **VirtualBox Platform Packages**, choose **Windows hosts**.
3. Run the downloaded installer as an administrator.
4. Keep the default components unless you know you need a different location.
5. Complete the wizard and launch Oracle VirtualBox.

The **Extension Pack is optional** for this guide. Install the matching version only if you need features such as VirtualBox USB 2.0/3.0 support, and review Oracle's license first.

### 3. Download the official Kali VirtualBox image

1. Open [Get Kali](https://www.kali.org/get-kali/).
2. Choose **Virtual Machines**.
3. Download the current **VirtualBox 64-bit** point-release image—not the VMware image and not the installer ISO.
4. Download the matching checksum from the same page or copy the published SHA256 value.

### 4. Verify the download

Open PowerShell in the download folder and run:

```powershell
Get-FileHash .\kali-linux-*-virtualbox-amd64.7z -Algorithm SHA256
```

Compare the output with the SHA256 published next to the current VirtualBox image on Kali's download page. They must match exactly. You can also use the helper in [`scripts/verify-kali-hash.ps1`](scripts/verify-kali-hash.ps1).

### 5. Extract the Kali archive

1. Install [7-Zip](https://www.7-zip.org/) if needed.
2. Right-click the downloaded `.7z` file.
3. Select **7-Zip → Extract to “kali-linux-…-virtualbox-amd64\\”**.
4. Keep the extracted folder in a permanent location, such as `C:\VMs\Kali`. Do not run the VM from Downloads if you regularly clean that folder.

### 6. Add the VM to VirtualBox

1. Open Oracle VirtualBox Manager.
2. Click **Add** (or **Machine → Add**).
3. Open the extracted Kali folder.
4. Select the file ending in `.vbox`, then choose **Open**.

This is an **Add** workflow, not **Import Appliance**. Kali's current prebuilt archive contains the VirtualBox configuration and virtual disk.

### 7. Review safe settings and start Kali

With the VM powered off, open **Settings** and confirm:

- **System → Base Memory:** 2048 MB for an 8 GB host, or 4096 MB for a 16 GB+ host
- **System → Processor:** 2 CPUs
- **Display → Video Memory:** 128 MB
- **Display → Graphics Controller:** VMSVGA
- **Network → Adapter 1:** NAT
- Leave **Bridged Adapter** off until a specific authorized lab requires it

Start the VM. The official prebuilt image currently uses:

```text
Username: kali
Password: kali
```

### 8. Secure and update the VM

Change the default password immediately:

```bash
passwd
```

Then update Kali:

```bash
sudo apt update
sudo apt full-upgrade -y
sudo reboot
```

### 9. Create a clean snapshot

After the reboot, shut down Kali normally. In VirtualBox, select the VM, open **Snapshots**, and create one named:

```text
Clean Install - Updated
```

Snapshots are restore points for lab mistakes; they are not backups. Keep important reports and notes outside the VM or in a separate backup.

## Optional: install from an ISO instead

Use the prebuilt image unless you specifically want to practice Linux installation or customize partitions, users, or desktop packages. The full ISO path is documented in [docs/iso-install.md](docs/iso-install.md).

## Networking for cybersecurity labs

| Mode | VM internet | Visible on LAN | Recommended use |
| --- | --- | --- | --- |
| NAT | Yes | No direct LAN presence | Default browsing, updates, TryHackMe/VPN |
| NAT Network | Yes | VMs can communicate with each other | Small multi-VM labs |
| Host-only | Usually no | Host and lab VMs only | Isolated attack/defense lab |
| Bridged | Yes | Yes | Only when an authorized lab requires LAN access |

For vulnerable targets, prefer a **Host-only** or controlled **NAT Network** and never expose an intentionally vulnerable VM to a school, workplace, apartment, or public network.

## Troubleshooting

See [docs/troubleshooting.md](docs/troubleshooting.md) for fixes covering:

- “VT-x/AMD-V is not available” or missing 64-bit guest options
- Black screen, frozen boot, or display corruption
- Slow performance on an 8 GB laptop
- No network connection
- Clipboard, drag-and-drop, or auto-resize not working
- Hyper-V/WSL/Docker conflicts
- Moving the VM without breaking its `.vbox` path

## Repository layout

```text
.
├── README.md
├── DISCLAIMER.md
├── docs/
│   ├── iso-install.md
│   └── troubleshooting.md
├── scripts/
│   └── verify-kali-hash.ps1
└── assets/screenshots/
    └── 01–07 walkthrough images
```

## Educational use

This repository is an independent educational guide. It is not affiliated with or endorsed by Oracle, VirtualBox, Kali Linux, OffSec, or any other organization. Product names and trademarks belong to their respective owners. See [DISCLAIMER.md](DISCLAIMER.md).
