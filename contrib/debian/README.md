
Debian
====================
This directory contains files used to package demystifyd/demystify-qt
for Debian-based Linux systems. If you compile demystifyd/demystify-qt yourself, there are some useful files here.

## demystify: URI support ##


demystify-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install demystify-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your demystify-qt binary to `/usr/bin`
and the `../../share/pixmaps/demystify128.png` to `/usr/share/pixmaps`

demystify-qt.protocol (KDE)

