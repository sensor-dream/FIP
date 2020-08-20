# Gnome-shell tuning

### Installing the required packages

```
packs=(
  gawk                    # The GNU version of the AWK text processing utility
  git                     # Fast Version Control System  
  glib2-devel             # The glib2-devel package includes the header files for the GLib library.
  gnome-extensions-app    # GNOME Extensions is an application for configuring and removing GNOME Shell extensions.
  gnome-menus             # A menu system for the GNOME project
  gnome-themes-extra
  gnome-tweaks
  GraphicsMagick          # An ImageMagick fork, offering faster image generation and better quality
  gtk2-engines
  gtk-murrine-engine
  gtk-update-icon-cache
  ImageMagick             # An X application for displaying and manipulating images
  inkscape
  libgnome-devel
  libgnomekbd-devel
  libgnome-keyring-devel
  libgnomeui-devel
  libpng-devel
  libX11-devel
  libXcursor-devel
  python37
  python3-pip
  xorg-x11-apps
  xorg-x11-utils
)

sudo dnf install ${packs[@]}

```

### Installing gnome-shell themes from packages extensions

```
packs=(
  gnome-shell-extension-background-logo # Background logo extension for GNOME Shell
  gnome-shell-extension-common          # Files common to GNOME Shell Extensions
  gnome-shell-extension-dash-to-dock    # Dock for the Gnome Shell by micxgx@gmail.com
  gnome-shell-extension-drive-menu      # Drive status menu for GNOME Shell
  gnome-shell-extension-freon           # GNOME Shell extension to display system temperature, voltage, and fan speed
  gnome-shell-extension-openweather     # Display weather information from many locations in the world
  gnome-shell-extension-user-theme      # Support for custom themes in GNOME Shell
  flat-remix-gtk3-theme                 # Flat Remix GTK theme is a pretty simple GTK window theme inspired on material design following a modern design using "flat" colors with high contrasts and sharp borders.
  flat-remix-theme                      # Flat Remix GTK theme is a pretty simple GTK window theme inspired on material design following a modern design using "flat" colors with high contrasts and sharp borders.
)

sudo dnf install ${packs[@]}
```

### Installing gnome-shell icons from external packages extensions

```
sudo dnf copr enable peterwu/rendezvous
sudo dnf install bibata-cursor-theme


```
