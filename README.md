
# YAHM
**Yet Another Homematic Management** - Skripte zur Einrichtung der Homematic CCU2 Oberfläche in einem LXC Container unter Arch Linux Arm auf einem Raspberry Pi 3.

Zur Zeit wurde dieses Skript auf folgender Hardware erfolgreich getestet:
* Rapsberry Pi 3

Folgende Betrebssysteme werden aktuell unterstützt:
* Arch Linux Arm

# Installation:

Es wird automatisch ein aktuelles CCU2 Image installiert und das Netzwerk konfiguriert. Diese Installation ist für wenig erfahrene Benutzer auf einem **frischen minimalen Debian/Raspbian** empfehlenswert.  Die frisch installierte CCU2 wird eine IP per DHCP abrufen, diese kann durch **sudo yahm-ctl info** nach dem Start des Containers angezeigt werden.

```
wget -nv -O- https://raw.githubusercontent.com/Myst3rion09/YAHM/master/yahm-init | sudo -E  bash -
```

# Updates
Mit **sudo yahm-ctl update** kann YAHM Installation (nicht CCU2 Firmware) jederzeit aktualisiert werden. Für die Aktualisierung der CCU2 Installation, siehe [LXC Container](https://github.com/leonsio/YAHM/wiki/YAHM-LXC)


# EQ3 HM-MOD-RPI-PCB Funkmodul
Nach einem Kernel Update muss pivccu-driver modul neu installier werden:

```
sudo yahm-module -f -m pivccu-driver enable
```

**Achtung:** Im Zuge der Installation wird ein Reboot benötigt

## Credits
[leonsio](https://github.com/leonsio/YAHM), [bullshit](https://github.com/bullshit/lxccu), [LXCCU](http://www.lxccu.com).<br >
Overlay und generischer UART Treiber by [piVCCU](https://github.com/alexreinert/piVCCU)
