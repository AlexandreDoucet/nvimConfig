NVIM_FOLDER="$HOME/.config/nvim"
lOCAL_NVIM_FOLDER="$HOME/.local/share/nvim/"
REPO_URL="https://github.com/AlexandreDoucet/nvimConfig.git"
if command -v git >/dev/null 2>&1; then
    echo "Git is already installed."
else
    echo "Git is not installed. Installing..."
fi

FOLDERS=("$NVIM_FOLDER" "$lOCAL_NVIM_FOLDER")

for FOLDER in "${FOLDERS[@]}"; do
    # Check if the folder exists
    echo $FOLDER
    if [ -d "$FOLDER" ]; then
        # Remove the contents but keep the directory
        rm -rf "$FOLDER"
        echo "Directory exists, contents removed: $FOLDER"
    else
        # Create the directory and any necessary parent directories
        echo "Directory created: $FOLDER"
    fi
    mkdir -p "$FOLDER"
done



git clone "$REPO_URL" "$NVIM_FOLDER"


if ! command -v gcc &> /dev/null
then
    echo "C compiler not found! Installing build-essential..."

    # Check if the system uses apt (for Ubuntu/Debian)
    if command -v apt &> /dev/null
    then
        sudo apt update
        sudo apt install -y build-essential
        echo "build-essential installed successfully."
    else
        echo "apt not found! Please install a C compiler manually."
        exit 1
    fi
else
    echo "C compiler is already installed."
fi

sudo apt update

sudo apt install -y python3.11
sudo apt install -y python3.11-venv
sudo apt install unzip

if ! command -v rustup &> /dev/null
then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi
exec bash
rustup component add rust-analyzer

