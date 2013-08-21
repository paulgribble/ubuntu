#!/bin/sh

# FIRST you will need to do the following:
# 1. open a ROOT terminal
# type adduser <yourusername> sudo
#   (where <yourusername> is your short username)
#   (if you don't know it, open a regular terminal and
#    type whoami)
# 2. logout
# 3. log back in
# 4. open a regular terminal and start this script by typing
#    /bin/sh debian_install.sh
# if you already have sudo priviledges on your username you
# can skip steps 1, 2, 3

echo "updating"
sudo apt-get -qq update
sudo apt-get -qq upgrade

# git source control
echo ""
echo "installing git"
sudo apt-get -qq install git

# developer tools
echo ""
echo "installing developer tools"
sudo apt-get -qq install build-essential

# linux kernel headers
echo ""
echo "installing linux kernel headers"
sudo apt-get -qq install linux-headers-$(uname -r)

# emacs
echo ""
echo "installing emacs"
sudo apt-get -qq install emacs emacs-goodies-el
# more emacs stuff
sudo cp org-exp-bibtex.el /usr/share/emacs/site-lisp/
sudo apt-get install -qq bibtex2html
cp dotemacs ~/.emacs

# org-mode
echo ""
echo "installing orgmode"
sudo apt-get -qq install org-mode

# R statistical package
echo ""
echo "installing R"
sudo apt-get -qq install r-base ess

# octave
echo ""
echo "installing octave"
sudo apt-get -qq install octave

# gsl, plotutils, gnuplot
echo ""
echo "installing gnu scientific library, plotutils, gnuplot"
sudo apt-get -qq install libgsl0-dev plotutils gnuplot

# pandoc document conversion
echo ""
echo "installing pandoc"
sudo apt-get -qq install pandoc

# LaTeX document typesetting system
echo ""
echo "installing LaTeX"
sudo apt-get -qq install texlive-full texlive-fonts-extra cm-super texlive-latex-extra auctex texinfo
texconfig paper letter
mktexlsr

# fonts
echo ""
echo "installing a bunch of fonts"
wget http://www.tug.org/fonts/getnonfreefonts/install-getnonfreefonts
chmod +x install-getnonfreefonts
./install-getnonfreefonts
getnonfreefonts garamond
mktexlsr
sudo apt-get -qq install ttf-mscorefonts-installer
sudo apt-get -qq install xfonts-100dpi xfonts-75dpi

# python scientific stack
echo ""
echo "installing python scientific stack"
sudo apt-get -qq install python-sip pyqt4-dev-tools
sudo apt-get -qq install python-numpy python-scipy python-matplotlib ipython ipython-doc ipython-notebook ipython-qtconsole python-sympy python-virtualenv python-dev python-pip
sudo apt-get -qq install python-pygame

# tor
echo ""
echo "installing tor"
sudo apt-get -qq install tor

# generate ssh key
echo ""
echo "generating ssh key"
echo "just hit <ENTER> when asked questions, until the procedure stops"
ssh-keygen -t rsa

# laptop?
while true; do
    read -p "install laptop-mode-tools? (y/n) " yn
    case $yn in
        [Yy]* ) echo ""; echo "installing laptop-mode-tools"; sudo apt-get -qq install laptop-mode-tools; break;;
        [Nn]* ) exit;;
        * ) echo "please answer y or n.";;
    esac
done

# update reps and upgrade any leftovers
echo ""
echo "update & upgrade"
sudo apt-get -qq update
sudo apt-get -qq upgrade

# managed network
echo ""
echo "configuring network interface to be managed"
sudo echo -e "[main]\nplugins=ifupdown,keyfile\n\n[ifupdown]\nmanaged=true" > /etc/NetworkManager/NetworkManager.conf

# done
echo ""
echo "DONE!"

