
# ICON TREESITTER AND TERMINAL
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
unzip JetBrainsMono.zip -d ~/.local/share/fonts/
fc-cache -fv
rm JetBrainsMono.zip 

# Sur Linux (téléchargement du binaire) OHMYPOSH
curl -s https://ohmyposh.dev/install.sh | bash -s
