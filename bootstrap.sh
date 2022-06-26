#! /bin/bash

#add chaotic-aur
sudo pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key FBA220DFC880C036
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

echo "\n" | sudo tee /etc/pacman.conf
echo "[chaotic-aur]" | sudo tee /etc/pacman.conf
echo "Include = /etc/pacman.d/chaotic-mirrorlist" | sudo tee /etc/pacman.conf

#install paru
git clone https://aur.archlinux.org/paru.git
cd paru/
sudo makepkg -sri
cd ..
rm -rf paru/

sudo pacman -S --noconfirm --needed bspwm sxhkd polybar rofi nitrogen discord element-desktop firefox-nightly nnn thunderbird flameshot light physlock curl nerd-fonts-fira-code xorg xorg-xinit noto-fonts-emoji

#get repos
git clone https://github.com/fanoplanes/.dots.git
git clone https://github.com/UnnatShaneshwar/OneDarkWallpapers.git

#get st going
git clone https://git.suckless.org/st
cd st
curl https://st.suckless.org/patches/clipboard/st-clipboard-0.8.3.diff --output st-clipboard-0.8.3.diff
curl https://st.suckless.org/patches/csi_22_23/st-csi_22_23-0.8.5.diff --output st-csi_22_23-0.8.5.diff
curl https://st.suckless.org/patches/font2/st-font2-20190416-ba72400.diff --output st-font2-20190416-ba72400.diff
curl https://st.suckless.org/patches/glyph_wide_support/st-glyph-wide-support-boxdraw-20220411-ef05519.diff --output st-glyph-wide-support-boxdraw-20220411-ef05519.diff
curl https://st.suckless.org/patches/scrollback/st-scrollback-ringbuffer-0.8.5.diff --output st-scrollback-ringbuffer-0.8.5.diff
curl https://st.suckless.org/patches/scrollback/st-scrollback-mouse-20220127-2c5edf2.diff --output st-scrollback-mouse-20220127-2c5edf2.diff
curl https://st.suckless.org/patches/xresources/st-xresources-20200604-9ba7ecf.diff --output st-xresources-20200604-9ba7ecf.diff
patch < *.diff
cp ../.dots/st_config.h config.h
sudo make
sudo make install
cd ~

mkdir .config

mkdir bspwm
cp ../.dots/bspwmrc bspwm/bspwmrc
chmod 755 bspwm/bspwmrc

mkdir sxhkd
cp ../.dots/sxhkdrc sxhkd/sxhkdrc
chmod 644 sxhkdrc

mkdir polybar
cp ../.dots/polybar_config.ini polybar/config.ini

mkdir zathura
cp ../.dots/zathurarc zathura/zathurarc

cp ../.dots/rofi rofi/

cd ~

cp .dots/.vimrc .vimrc
cp .dots/.xinitrc .xinitrc
cp .dots/.Xresources .Xresources
cp .dots/.alacritty.yml .alacritty.yml

cd ~

startx

nitrogen ~/OneDarkWallpapers/06.png
