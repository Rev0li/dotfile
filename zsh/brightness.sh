lumos() {
    if [ -z "$1" ]; then
        echo "Usage: set_br <value>"
        echo "Where <value> is a percentage (20 to 100)."
        return 1
    fi

    if [ "$1" -lt 20 ] || [ "$1" -gt 100 ]; then
        echo "Error: Value must be between 20 and 100."
        return 1
    fi

    active_display=$(xrandr --listmonitors | awk '/\*/ {print $4}')
    if [ -z "$active_display" ]; then
        echo "Error: Could not find an active display."
        return 1
    fi

    brightness=$(echo "$1 / 100" | bc -l)

    xrandr --output "$active_display" --brightness "$brightness"
    if [ $? -eq 0 ]; then
        echo "Brightness set to $1% for display: $active_display."
    else
        echo "Error: Failed to set brightness for display: $active_display."
        return 1
    fi
}
