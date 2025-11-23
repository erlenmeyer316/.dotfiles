#!/usr/bin/env bash
set -euo pipefail

{{ template "shared_script_utils.bash" . }}

install_vscode() {
    if dpkg -s code &> /dev/null; then
       info "Visual studio code is already installed"
       continue
    fi

	# Microsoft GPG key
	curl -fsSL https://packages.microsoft.com/keys/microsoft.asc |
	  gpg --dearmor |
	  sudo tee /usr/share/keyrings/microsoft.gpg > /dev/null

	# Add VS Code repo (Debian/Ubuntu)
	echo "deb [arch=$(dpkg --print-architecture) \
	signed-by=/usr/share/keyrings/microsoft.gpg] \
	https://packages.microsoft.com/repos/code stable main" |
	  sudo tee /etc/apt/sources.list.d/vscode.list

	# Update and install
	sudo apt-get update -y
	info "Installing visual studio code"
	sudo apt-get install -y code
}

uninstall_vscode() {
	if dpkg -s code &> /dev/null; then
	   info "Uninstalling visual studio code"
       sudo apt-get uninstall -y code
	   sudo apt-get autoremove
    fi
}