#!/bin/bash

# Initialize the convert command with the atlas
bgcolor="#123646"
cmd="convert -size 4096x4096 xc:${bgcolor}"

# Loop from 0 to 355 degrees in 5-degree steps (72 iterations)
for ((angle=0; angle<=355; angle+=5)); do
  # Calculate row (0 to 11) and column (0 to 5)
  index=$((angle / 5))           # 0 to 71
  col=$((index % 6))             # Column: 0 to 5
  row=$((index / 6))             # Row: 0 to 11
  x=$((col * 632))               # X: 0, 632, 1264, 1896, 2528, 3160
  y=$((row * 317))               # Y: 0, 317, 634, ..., 3487

  # Add the processing block for this angle
  cmd="$cmd \( \
    \( background.png -background none -crop 632x317+79+55 +repage \)  \
    \( -size 640x640 xc:none input.png -gravity center -composite -background none -rotate $angle \
    \( -clone 0 -background none -alpha set -channel A -evaluate multiply 0.5 +channel \) -geometry +5+5 -composite \
    \( pins.png -background none -rotate $angle \) -gravity center -composite -gravity center -extent 316x317 \
    -duplicate 1 -gravity west +append \) \
    -gravity center -composite \
    \( foreground.png -background none -crop 632x317-6-29 +repage \) -gravity center -composite \
    \) \
    -geometry +${x}+${y} -gravity northwest -composite"
done

# Finalize with output file and execute
cmd="$cmd atlas.png"
eval "$cmd"

etc1tool atlas.png
