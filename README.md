# Dotfiles

## Things Used
- ZSH
- PowerLevel10k
- Neovim
- Tmux
- Ly
- And most importantly <b><i>My creative Mind!!</i></b>

## How to Setup?
Checkout [this](https://www.atlassian.com/git/tutorials/dotfiles) and [this](https://wiki.archlinux.org/title/Dotfiles#Tracking_dotfiles_directly_with_Git) for more

[Good blog](https://fernandocejas.com/blog/engineering/2022-03-30-arch-linux-system-maintance/)

(Hard links in .config/etc)

- Copy contents of .config/etc/ly_config.ini to /etc/ly/config.ini
- Copy contents of .config/etc/grub to /etc/default/grub
- Copy contents of .config/etc/30-touchpad.conf to /etc/X11/xorg.conf.d/30-touchpad.conf
- Copy contents of .config/etc/pacman.conf to /etc/pacman.conf

### Ly (make it faster)

Change `Type=idle` to `Type=simple` in `/usr/lib/systemd/system/ly.service`

[Reference](https://github.com/fairyglade/ly/issues/305#issuecomment-1108996377)

## Canon LBP2900 Setup (important)

Install cups, capt-src (AUR) acc to instructions
Install foomatic-*, gutenprint, system-config-printer

[Checkout](https://askubuntu.com/questions/463289/cant-get-my-canon-lbp-printer-to-run-under-ubuntu-14-04/464334#464334)

```bash
sudo grep -H LBP2900 /usr/share/cups/model/*.ppd
sudo lpadmin -p LBP2900 -m CNCUPSLBP2900CAPTK.ppd -v ccp://localhost:59687
sudo lpadmin -p LBP2900 -E
sudo ccpdadmin -p LBP2900 -o /dev/usb/lp0
captstatusui -P LBP2900 #works
```
