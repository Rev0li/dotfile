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
  git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions 2>/dev/null || true
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting 2>/dev/null || true
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

install_nerd_font() {
  FONT_NAME="FiraCode"
  FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/FiraCode.zip"
  FONT_DIR="$HOME/.local/share/fonts"

  echo "Téléchargement de la police Nerd Font ($FONT_NAME)..."
  mkdir -p "$FONT_DIR"
  curl -Lo "$FONT_DIR/$FONT_NAME.zip" "$FONT_URL"

  echo "Extraction des fichiers de police..."
  unzip -o "$FONT_DIR/$FONT_NAME.zip" -d "$FONT_DIR" > /dev/null
  rm "$FONT_DIR/$FONT_NAME.zip"

  echo "Mise à jour du cache des polices utilisateur..."
  fc-cache -fv "$FONT_DIR" > /dev/null
  log+=("✔️ Police $FONT_NAME Nerd Font installée.")
}


# Function to symlink files
symlink_files() {
  # Handle .zshrc
  if [ -e "$HOME/.zshrc" ]; then
    rm -f "$HOME/.zshrc"
    log+=("✔️ Ancien fichier ~/.zshrc supprimé.")
  fi
  ln -sf $PWD/../zsh/.zshrc $HOME/.zshrc
  log+=("✔️ Fichier ~/.zshrc lié.")

  # Handle Neovim config
  if [ -e "$HOME/.config/nvim" ]; then
    rm -rf "$HOME/.config/nvim"
    log+=("✔️ Ancienne configuration Neovim supprimée.")
  fi
  mkdir -p $HOME/.config
  ln -sf $PWD/../nvim $HOME/.config/nvim
  log+=("✔️ Configuration Neovim liée.")
}

# Run the installation steps
install_oh_my_zsh
install_zsh_plugins
install_nerd_font
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

echo "==============================="
echo "Installation terminée. Rechargez votre terminal si nécessaire !"

