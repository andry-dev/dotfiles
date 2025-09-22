#!/usr/bin/env -S uv run --script

# /// script
# dependencies = [
#   'spectra'
# ]
# ///

import spectra

COLORS = 16


CHROMA = 20
HUE = 25

LIGHT_START = 0
LIGHT_STEP = (50 - LIGHT_START) / COLORS

DARK_START = 60
DARK_STEP = (100 - DARK_START) / COLORS


def gen_colors(start: int, step: float):
    tab = '    '
    print(f"{tab}ansi = {{")
    for i in range(0, COLORS, 2):
        print(f"{tab}{tab}'lch({start + i * step}% {CHROMA} {HUE})',")

    print(f"{tab}}},\n")

    print(f"{tab}brights = {{")
    for i in range(1, COLORS, 2):
        print(f"{tab}{tab}'lch({start + i * step}% {CHROMA} {HUE})',")

    print(f"{tab}}},\n")

def gen_colors_rgb(start: int, step: float):
    for i in range(0, COLORS, 2):
        lch = spectra.lch(start + i * step, CHROMA, HUE)
        print(f'let g:terminal_color_{i} = "{lch.hexcode}"')

    for i in range(1, COLORS, 2):
        lch = spectra.lch(start + i * step, CHROMA, HUE)
        print(f'let g:terminal_color_{i} = "{lch.hexcode}"')

print(f'step: {LIGHT_STEP}\n')

print("LIGHT:\n")
gen_colors(LIGHT_START, LIGHT_STEP)
gen_colors_rgb(LIGHT_START, LIGHT_STEP)

print("\nDARK:\n")
gen_colors(DARK_START, DARK_STEP)

gen_colors_rgb(DARK_START, DARK_STEP)
