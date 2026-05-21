#!/usr/bin/env bash
# Position the two identical LEN P27q-10 monitors for the office V-H-V layout.
# Uses EDID hashes to identify physical monitors regardless of connector names.
# Called by kanshi after the office profile is matched.
#
# To update hashes: sha256sum /sys/class/drm/card*-DP-*/edid (filter empty ones)

LEFT_EDID="7e9e0b9c70402c79c1c86d48ded61608c78c2e1e5ad9dadd773d22a7b5f2401b"
CENTER_EDID="368c486a0f976103d82b43d4c68644a3e14e5d0e7d65615f4d888a0eee6adaea"
EMPTY_EDID="e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

find_connector() {
    local target="$1"
    for edid_path in /sys/class/drm/card*-DP-*/edid; do
        local hash
        hash=$(sha256sum "$edid_path" 2>/dev/null | cut -d' ' -f1)
        [[ "$hash" == "$EMPTY_EDID" ]] && continue
        if [[ "$hash" == "$target" ]]; then
            basename "$(dirname "$edid_path")" | sed 's/^card[0-9]*-//'
            return 0
        fi
    done
    return 1
}

left=$(find_connector "$LEFT_EDID")
center=$(find_connector "$CENTER_EDID")

if [[ -z "$left" || -z "$center" ]]; then
    notify-send -u low "office-monitors" \
        "Could not identify both LEN P27q-10 monitors via EDID (left='$left' center='$center')"
    exit 1
fi

hyprctl keyword monitor "$left, 2560x1440, 0x0, 1, transform, 3"
hyprctl keyword monitor "$center, 2560x1440, 1440x560, 1"
