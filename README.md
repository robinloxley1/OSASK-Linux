OSASK-Linux
===========

This is personal practice for OSASK's book on linux node.
Original code is for windows environment, while this repository is running the same concepts of the original code for ubuntu.

Environment
-----------
OS: Ubuntu 12.04
Editor: vi
Emulator: QEMU

Install Image on QEMU
---------------------
Testing images on QEMU is a common task. This section talks about how to install images on QEMU in the linux environment.

Qemu is a virtualization emulator running on hosting os (ubuntu in my case). Qemu has a universal distribution with ubuntu. Type qemu- will list a batch of qemu related binaries, however qemu commend itself is not enlisted.

P.S. I tried to install from qemu official git. It ended up with configuration failures with my EC2 ubuntu.

Turing to the default qemu with ubuntu, use qemu-system-x86_64 to replace qemu.
```shell
qemu-system-x86_64 -fda workstation/OSASK-Linux/src/helloos.img
```
return error
> Could not access KVM kernel module: No such file or directory
> failed to initialize KVM: No such file or directory
> Back to tcg accelerator.
> Failed to allocate 402653184 B: Cannot allocate memory
> Aborted (core dumped)
There are two errors, no KVM and no enough memory.
From [KVM install](http://blog.csdn.net/yuqinying112/article/details/7186415), try `egrep -c '(vmx|svm)' /proc/cpuinfo` which returns `0`, meaning CPU does not support virtualization. Therefore, I need to enable flag `-no-kvm` to disable hardware accerlation. Note, qemu is independent of kvm.

For memory allocation, use flag `-m 32` to limit 32MB memory.

```shell
qemu-system-x86_64 -m 32 -no-kvm -fda workstation/OSASK-Linux/src/helloos.img
```
return error
> Could not initialize SDL(No available video device) - exiting
Qemu by default export visualization through vga, but since running on ec2 instance, there is no vga device. Flag `-curses` can be used to direct output to std with no graphics. However, for the rest of practice, it is necessary to have a graphical UI. Flag `-vnc` is used to redirect output to a vnc4server program.

```shell
sudo apt-get install gnome-core
sudo apt-get install vnc4server
vim .vnc/xstartup
vncserver

qemu-system-x86_64 -vnc 0.0.0.0:1 -m 32 -no-kvm -fda workstation/OSASK-Linux/src/helloos.img
```
Open a vnc client (tightvnc in my case) and connect to the ec2 instance. Be sure to enable port 5901 in the aws security group.




Miscellaneous
-------------
This sector summarizes some useful tips when practicing the coding.

* View code comments in Japanese
The comments in Japanese is Shift-JIS, but since system does not support SJIS in general, the easiest way to view comments is from github raw code browser with UTF-8. Note: viewing from changeset rather than raw code will cause browser to interprete SJIS differently.
