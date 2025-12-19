#!/usr/bin/env bash
set -euo pipefail

{{ template "shared_script_utils.bash" . }}

#!/usr/bin/env bash
set -euo pipefail

# DickiNas remote device ID
DICKINAS_ID="7QPLJJ2-3ZBQKPB-5OWUBZI-YF3MHST-QIRPSEC-PMNA426-FB64FU2-BOLNTQQ"

CONFIG_FILE="$HOME/.config/config.xml"
LOCAL_DIR="$HOME/.local/syncthing"
SYNC_DIR="$HOME/Sync"


_generate_config_if_missing() {
    if [[ ! -f "$CONFIG_FILE" ]]; then
        echo "[*] Generating fresh Syncthing config"
        mkdir -p "$CONFIG_DIR"
        syncthing --generate="$CONFIG_DIR"
    else
        echo "[✓] Config already exists"
    fi
    
    if [[ ! -d "$LOCAL_DIR" ]]; then
       echo "[*] Creating local dir"
       mkdir -p "$LOCAL_DIR"
    else
       echo "[✓] Local dir already exists"
    fi
}

_set_local_device_name() {
    local hostname_val
    hostname_val=$(hostname)

    # Syncthing always puts the local device as the first <device> entry
    local current_name
    current_name=$(xmlstarlet sel -t -v "//device[@id][1]/@name" "$CONFIG_FILE")

    if [[ "$current_name" != "$hostname_val" ]]; then
        echo "[*] Setting local device name to $hostname_val"
        xmlstarlet ed --inplace \
            -u "//device[@id][1]/@name" \
            -v "$hostname_val" \
            "$CONFIG_FILE"
    else
        echo "[✓] Local device name is already $hostname_val"
    fi
}

_set_default_folder_path() {
    mkdir -p "$SYNC_DIR"

    local exists
    exists=$(xmlstarlet sel -t -v "count(/configuration/defaults/folder)" "$CONFIG_FILE")

    if [[ "$exists" == "0" ]]; then
        echo "[*] Creating <defaults><folder> with path $SYNC_DIR"
        xmlstarlet ed --inplace \
          -s "/configuration" -t elem -n "defaults" -v "" \
          -s "/configuration/defaults" -t elem -n "folder" -v "" \
          -i "/configuration/defaults/folder" -t attr -n "path" -v "$SYNC_DIR" \
          "$CONFIG_FILE"
    else
        local current
        current=$(xmlstarlet sel -t -v "/configuration/defaults/folder/@path" "$CONFIG_FILE")

        if [[ "$current" != "$SYNC_DIR" ]]; then
            echo "[*] Updating default folder path to $SYNC_DIR"
            xmlstarlet ed --inplace \
              -u "/configuration/defaults/folder/@path" \
              -v "$SYNC_DIR" \
              "$CONFIG_FILE"
        else
            echo "[✓] Default folder path already set to $SYNC_DIR"
        fi
    fi
}

_add_dickinas_device() {
    local exists
    exists=$(xmlstarlet sel -t -v "count(//device[@id='$DICKINAS_ID'])" "$CONFIG_FILE")

    if [[ "$exists" == "0" ]]; then
        echo "[*] Adding DickiNas device entry"
        xmlstarlet ed --inplace \
          -s "//configuration" -t elem -n "deviceTMP" -v "" \
          -i "//deviceTMP" -t attr -n "id" -v "$DICKINAS_ID" \
          -i "//deviceTMP" -t attr -n "name" -v "DickiNas" \
          -i "//deviceTMP" -t attr -n "autoAcceptFolders" -v "true" \
          -s "//deviceTMP" -t elem -n "address" -v "dynamic" \
          -r "//deviceTMP" -v "device" \
          "$CONFIG_FILE"
    else
        echo "[✓] DickiNas already configured"
    fi
}

_start_syncthing_background() {
    if pgrep syncthing >/dev/null 2>&1; then
        echo "[✓] Syncthing already running"
        return
    fi

    echo "[*] Starting Syncthing"
    syncthing serve --no-browser
}


install_syncthing() {
    if dpkg -s syncthing &> /dev/null; then
       info "Syncthing is already installed"
       return
    fi

	info "Installing syncthing"
    sudo apt-get install -y syncthing xmlstarlet
}

uninstall_syncthing() {
    if dpkg -s syncthing &> /dev/null; then
	   info "Uninstalling syncthing"
       sudo apt-get uninstall -y syncthing xmlstarlet 
	   sudo apt-get autoremove
    fi
}

configure_syncthing(){
    generate_config_if_missing
    set_local_device_name
    set_default_folder_path
    add_dickinas_device
}

start_syncthing_daemon(){
    start_syncthing_background
}