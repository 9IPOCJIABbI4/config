export GDK_SCALE=2
export GDK_DPI_SCALE=0.5

prlcc &
sxhkd &
xrdb ~/.Xresources
wal -R
exec bspwm
