# Troubleshooting Kali on VirtualBox

Power off the VM before changing virtual hardware settings.

## Virtualization is disabled or 64-bit options are missing

1. Open **Task Manager → Performance → CPU** and check **Virtualization**.
2. If disabled, enter BIOS/UEFI and enable Intel VT-x/Intel Virtualization Technology or AMD-V/SVM.
3. Fully shut down and restart Windows after changing firmware settings.
4. On a managed school or work laptop, ask IT before changing firmware or Windows security features.

## VirtualBox reports a Hyper-V or hypervisor conflict

Modern VirtualBox can run on some Windows systems where Microsoft's hypervisor is active, but performance may be lower. Hyper-V, Windows Sandbox, WSL2, Credential Guard, and Docker Desktop may depend on overlapping virtualization features.

Do not disable security or virtualization features blindly. First:

- Update VirtualBox to the current release.
- Reboot Windows.
- Close other hypervisors and try again.
- Keep the VM at 2 CPUs and 2 GB RAM while testing.

If it still fails, decide whether VirtualBox or Hyper-V/WSL2/Docker is more important on that host before changing Windows Features. On a school-managed laptop, contact IT.

## Black screen, graphical corruption, or frozen desktop

With the VM powered off:

1. Open **Settings → Display**.
2. Set **Graphics Controller** to `VMSVGA`.
3. Set **Video Memory** to `128 MB`.
4. Disable **3D Acceleration**.
5. Start the VM again.

## Kali is slow on an 8 GB host

- Allocate 2048 MB RAM and 2 CPUs to Kali.
- Close browsers, games, Docker Desktop, and unused VMs on Windows.
- Store the VM on an SSD.
- Avoid running a full upgrade while many GUI tools are open.
- Use Kali's default Xfce desktop.
- Do not over-allocate CPUs; the Windows host still needs resources.

## No internet inside Kali

1. Power off the VM.
2. Open **Settings → Network → Adapter 1**.
3. Enable the adapter, select **NAT**, and enable **Cable Connected**.
4. Boot Kali and test:

```bash
ip address
ping -c 3 1.1.1.1
ping -c 3 kali.org
```

If IP connectivity works but the hostname test fails, the issue is likely DNS. Restart NetworkManager:

```bash
sudo systemctl restart NetworkManager
```

## Clipboard, drag-and-drop, or automatic resize does not work

Update Kali and reinstall the guest package:

```bash
sudo apt update
sudo apt install -y --reinstall virtualbox-guest-x11
sudo reboot
```

Then check **Settings → General → Advanced** for clipboard and drag-and-drop choices. Treat shared clipboard, folders, and drag-and-drop as trust bridges between the VM and host; disable them while handling untrusted lab files.

## The VM disappeared after moving its folder

VirtualBox stores paths to the `.vbox` configuration and virtual disk.

1. Remove only the stale entry from VirtualBox Manager; do **not** choose to delete its files.
2. Move the entire extracted VM folder together.
3. Select **Machine → Add** and choose the `.vbox` file at its new location.

## Disk space is low

Delete unnecessary files inside Kali first:

```bash
sudo apt autoremove -y
sudo apt clean
df -h
```

Snapshots can consume substantial host disk space. Delete snapshots through VirtualBox Manager only after you understand which state you are removing.

Expanding the virtual disk in VirtualBox does not automatically expand Kali's partition and filesystem. Follow the current [Kali VirtualBox documentation](https://www.kali.org/docs/virtualization/install-virtualbox-guest-vm/) before resizing.

## USB Wi-Fi adapter is not visible

The VM cannot normally use the laptop's internal Wi-Fi adapter as a raw wireless interface. For monitor mode or packet injection, use a compatible external USB Wi-Fi adapter and attach it to the VM. USB 2.0/3.0 passthrough may require the matching VirtualBox Extension Pack.

Only monitor or test wireless networks you own or have explicit permission to assess.

