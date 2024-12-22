#!/bin/bash

# Initialize a log array to store messages
log=()

# Function to install Oh My Zsh
install_oh_my_zsh() {
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    log+=("✔️ Oh My Zsh a été installé.")
  else
    log+=("✔️ Oh My Zsh est déjà installé.")
  fi
}

# Function to install Zsh plugins
install_zsh_plugins() {
  ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
  git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
  log+=("✔️ Plugins Zsh installés (zsh-autosuggestions, zsh-syntax-highlighting).")
}

# Function to configure Neovim
configure_nvim() {
  if ! command -v nvim &> /dev/null; then
    log+=("❌ Neovim n'est pas installé. Veuillez l'installer avant de relancer ce script.")
    exit 1
  fi
  if [ ! -f "$HOME/.local/share/nvim/site/autoload/plug.vim" ]; then
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    log+=("✔️ vim-plug a été installé pour Neovim.")
  fi
  nvim +PlugInstall +qall
  log+=("✔️ Plugins Neovim installés.")
}

# Function to symlink files
symlink_files() {
	SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
	ln -sf "$SCRIPT_DIR/../zsh/.zshrc" "$HOME/.zshrc"

	mkdir -p $HOME/.config
	ln -sf "$SCRIPT_DIR/../zsh/.zshrc" "$HOME/.config/"
	log+=("✔️ Fichiers de configuration liés.")
}

# Run the installation steps
install_oh_my_zsh
install_zsh_plugins
configure_nvim
symlink_files

# Display the log at the end
echo
echo "==============================="
echo " RÉCAPITULATIF DE L'INSTALLATION"
echo "==============================="
for message in "${log[@]}"; do
  echo "$message"
done

echo
echo "Rechargement du fichier .zshrc..."
if [ -n "$ZSH_NAME" ]; then
  # Si nous sommes déjà dans Zsh, recharger .zshrc
  source $HOME/.zshrc
else
  # Si nous sommes dans Bash, lancer Zsh
  echo "Lancement de Zsh pour appliquer la configuration..."
  exec zsh
fi
log+=("✔️ Fichier .zshrc rechargé.")

echo "==============================="
echo "Installation terminée. Rechargez votre terminal si nécessaire !"

