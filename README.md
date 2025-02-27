# Dotfiles

## Things Used
- ZSH
- PowerLevel10k
- Neovim
- Tmux
- And most importantly <b><i>My creative Mind!!</i></b>

## How to Setup?
Checkout [this](https://www.atlassian.com/git/tutorials/dotfiles) and [this](https://wiki.archlinux.org/title/Dotfiles#Tracking_dotfiles_directly_with_Git)  for more

## Canon LBP2900 Setup (important)

Install cups, capt-src (AUR) acc to instructions
Install foomatic-*, gutenprint, system-config-printer

[Checkout](https://askubuntu.com/questions/463289/cant-get-my-canon-lbp-printer-to-run-under-ubuntu-14-04/464334#464334)

```bash
sudo grep -H LBP2900 /usr/share/cups/model/*.ppd
udo lpadmin -p LBP2900 -m CNCUPSLBP2900CAPTK.ppd -v ccp://localhost:59687
sudo lpadmin -p LBP2900 -E
sudo ccpdadmin -p LBP2900 -o /dev/usb/lp0
captstatusui -P LBP2900 #works
```
