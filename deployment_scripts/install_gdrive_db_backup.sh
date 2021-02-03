#!/bin/bash

echo "Installing gdrive"
cd ~
wget https://docs.google.com/uc?id=0B3X9GlR6EmbnWksyTEtCM0VfaFE&export=download -O gdrive

chmod +x gdrive
sudo install gdrive /usr/bin/gdrive

echo "gdrive installed successfully"
echo "Please run 'sudo gdrive list' to setup Google Drive credentials"