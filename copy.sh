!#/bin/bash

# Common
mkdir -p ~/.config/nvim
mkdir -p ~/.config/fastfetch
cp -r .config/nvim/* ~/.config/nvim
cp -r .config/fastfetch/* ~/.config/fastfetch

if uname | grep -q "Linux"; then

 

elif uname | grep -q "Darwin"; then


fi
