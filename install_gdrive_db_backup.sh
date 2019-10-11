#!/bin/bash

echo "Installing gdrive"
cd ~
wget https://docs.google.com/uc?id=0B3X9GlR6EmbnWksyTEtCM0VfaFE&export=download

mv uc\?id\=0B3X9GlR6EmbnWksyTEtCM0VfaFE gdrive
chmod +x gdrive
sudo install gdrive /usr/local/bin/gdrive

echo "gdrive installed successfully"
echo "Please run 'gdrive list' to setup Google Drive credentials"