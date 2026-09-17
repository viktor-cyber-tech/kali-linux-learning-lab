# Optional Manual ISO Installation

The official prebuilt VirtualBox image is faster and easier. Use this workflow when you want to practice the installer or need custom disk, user, desktop, or package choices.

## 1. Download the installer image

Open [Get Kali](https://www.kali.org/get-kali/) and download the current **Installer** image for `x86_64`. Verify its SHA256 using the process in the main README.

## 2. Create a new VM

In VirtualBox Manager, select **New** and use:

| Setting | Value |
| --- | --- |
| Name | Kali Linux |
| Type | Linux |
| Version | Debian (64-bit) |
| RAM | 4096 MB on this 32 GB host |
| CPUs | 2 |
| Disk format | VDI |
| Allocation | Dynamically allocated |
| Virtual disk maximum | 80 GB |

A dynamically allocated disk grows as data is written; it does not immediately consume the full 80 GB.

![VirtualBox New Virtual Machine wizard set to Linux and Debian 64-bit, with unattended installation disabled](../assets/screenshots/08-vm-os-selection.png)

> [!NOTE]
> This cropped lab screen shows the correct guest type: **Linux → Debian (64-bit)**. Keep **Proceed with Unattended Installation** unchecked, then configure the virtual hardware and disk before clicking **Finish**.

Leave **Set up unattended guest OS installation** alone: **Proceed with Unattended Installation** must remain unchecked. Kali's installer will then run normally, letting you choose your own account and password during setup. Leave **Install Guest Additions** unchecked; guest tools can be repaired later if needed.

### Configure virtual hardware

![VirtualBox virtual hardware settings with 4096 MB RAM and 2 CPUs](../assets/screenshots/10-virtual-hardware.png)

For this 32 GB host, use **4096 MB** of base memory and **2 CPUs**. Leave **Use EFI** unchecked. Do not give Kali more than half of the host's RAM or every available CPU.

### Create the virtual hard disk

Select **Create a New Virtual Hard Disk**, keep **VDI (VirtualBox Disk Image)** selected, and leave **Pre-allocate Full Size** and **Split Disk into 2 GB Parts** unchecked. Set the virtual disk maximum to **80 GB** before clicking **Finish**. The VDI is dynamically allocated, so it grows as Kali uses space rather than immediately consuming 80 GB.

## 3. Tune the VM before first boot

- **System → Boot Order:** Hard Disk first, Optical second
- **System → Processor:** 2 CPUs; enable PAE/NX
- **Display → Video Memory:** 128 MB
- **Display → Graphics Controller:** VMSVGA
- **Network → Adapter 1:** NAT
- If graphical corruption occurs, disable 3D acceleration

## 4. Mount the ISO

Open **Settings → Storage**, select the empty optical drive, choose the disk icon, and select the downloaded Kali ISO. Start the VM and choose **Graphical install**.

![Kali Linux installer boot menu in VirtualBox](../assets/screenshots/12-kali-installer-menu.png)

At this menu, use the arrow keys to highlight the first option, **Graphical install**, then press **Enter**. The **Install with speech synthesis** option shown in this screenshot is an accessibility option; use it only if you need speech output.

![Kali installer language selection with English selected](../assets/screenshots/13-language-selection.png)

Choose **English** (or your preferred language), then select **Continue**. This choice becomes the default language for the installed Kali system.

![Kali installer region selection with North America selected](../assets/screenshots/14-region-selection.png)

For the U.S. setup shown here, choose **North America**.

![Kali installer location selection with United States selected](../assets/screenshots/15-country-selection.png)

Then choose **United States**. This sets the locale and helps the installer select the correct time zone. Choose your own region and country if you live elsewhere.

![Kali installer keyboard selection with American English selected](../assets/screenshots/16-keyboard-selection.png)

Choose the keyboard layout you normally use. For this U.S. setup, select **American English**.

### Network identity

![Kali installer hostname prompt](../assets/screenshots/17-hostname.png)

Use a short, generic hostname such as `kali-lab` or `kali-learning-lab`; do not use your full name. This only identifies the VM on your local network.

![Kali installer domain-name prompt left blank](../assets/screenshots/18-domain-name.png)

Leave the domain-name field blank for a personal VirtualBox lab unless you own and administer a domain that belongs there.

### Create the local account

![Kali installer full-name prompt with the entry redacted](../assets/screenshots/19-full-name-redacted.png)

Enter a display name for the account. The screenshot entry is redacted because personal account details do not belong in a public guide.

![Kali installer username prompt with the entry redacted](../assets/screenshots/20-username-redacted.png)

Next, choose a lowercase username you are comfortable using in terminal commands. Create a long, unique password and store it in a password manager; do not publish or screenshot it.

### Set the clock and partition the virtual disk

Choose the time zone that matches where you live. Then select **Guided — use entire disk** and choose the Kali virtual disk—not any Windows host disk. Because this is the 80 GB VDI created above, guided partitioning only changes the VM's virtual disk.

![Kali installer partitioning scheme with all files in one partition selected](../assets/screenshots/21-partition-scheme.png)

For a first Kali lab, select **All files in one partition (recommended for new users)**. Finish partitioning and confirm the write changes prompt. Continue with the desktop/package choices, then let the installer complete.

![Kali installer confirmation to write changes to the virtual disk](../assets/screenshots/22-write-partition-changes.png)

Confirm **Yes** only after checking that the listed device is Kali's virtual disk. The installer then formats and installs to the VDI; it does not alter the Windows host disk.

### Software selection

![Kali installer software selection with Xfce and default tools selected](../assets/screenshots/23-software-selection.png)

Keep the default **Xfce** desktop and the default tool collection selected. It is a sensible baseline for a learning VM; install additional toolsets later only when you have a specific lab or course need.

### Install GRUB

![Kali installer prompt to install the GRUB boot loader](../assets/screenshots/24-install-grub.png)

Select **Yes** to install GRUB. Since this is a dedicated Kali VM, it is the only operating system on its virtual disk.

![Kali installer GRUB device selection with the VM identifier redacted](../assets/screenshots/25-grub-device-redacted.png)

Select **`/dev/sda`**, the virtual disk shown by the installer. Do not choose a manually entered device.

## 5. Finish and eject the ISO

![Kali installer completion screen](../assets/screenshots/26-installation-complete.png)

Select **Continue** to reboot. Remove the ISO when prompted. If the installer starts again, power off the VM and remove the ISO from **Settings → Storage** or change the boot order so the virtual hard disk comes first.

## 6. Update and verify guest tools

```bash
sudo apt update
sudo apt full-upgrade -y
sudo apt install -y --reinstall virtualbox-guest-x11
sudo reboot
```

Create a **Clean Install - Updated** snapshot after the first successful reboot.

Official references:

- [Kali inside VirtualBox](https://www.kali.org/docs/virtualization/install-virtualbox-guest-vm/)
- [VirtualBox User Manual](https://www.virtualbox.org/manual/UserManual.html)
