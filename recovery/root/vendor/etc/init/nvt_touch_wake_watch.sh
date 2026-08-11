#!/system/bin/sh
# nvt_touch_wake_watch.sh
# Watches backlight brightness and re-fires the blank->unblank toggle 
# to fb0/blank every time the screen wakes.

BACKLIGHT="/sys/class/leds/lcd-backlight/brightness"
FB_BLANK="/sys/class/graphics/fb0/blank"

# Baca nilai awal kecerahan
prev="$(cat "$BACKLIGHT" 2>/dev/null)"

while true; do
    sleep 0.5
    cur="$(cat "$BACKLIGHT" 2>/dev/null)"
    
    # Jika layar tadinya mati (0) dan sekarang menyala (>0)
    if [ "$prev" = "0" ] && [ "$cur" != "0" ]; then
        log -t nvt_touch_wake "Screen woke up! Kicking NVT driver via fb0..."
        
        # Pancing driver NVT
        echo 4 > "$FB_BLANK"
        sleep 0.2
        echo 0 > "$FB_BLANK"
    fi
    prev="$cur"
done
