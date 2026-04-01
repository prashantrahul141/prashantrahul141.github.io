#!/usr/bin/env python

import os
from os import path
from pathlib import Path
import random
import sys

from poisson_disc import PoissonDisc

from PIL import Image, ImageDraw, ImageFont, ImageOps, ImageEnhance

IMG_WIDTH, IMG_HEIGHT = 1284, 724

PRIMARY_TEXT_COLOR = "#ef5350"
SECONDARY_TEXT_COLOR = "#ffffff77"
BG_COLOR = "#1f1f1fff"
BORDER_WITDH = 2

FONT_TITLE = ImageFont.truetype("JetBrainsMonoNL-Regular.ttf", 60)
FONT_SUBTEXT = ImageFont.truetype("JetBrainsMonoNL-Regular.ttf", 28)

SCRIPT_DIR = Path(__file__).parent
DOODLES_DIR = path.join(SCRIPT_DIR, "thumbnail/")

AUTHOR_TEXT = "Prashant Rahul"


def create_image(text: str) -> Image.Image:
    # background
    background = Image.new("RGBA", (IMG_WIDTH, IMG_HEIGHT), BG_COLOR)

    # add doodles
    doodles = [i for i in os.listdir(DOODLES_DIR) if i.endswith("png")]

    poisson_sampling = PoissonDisc(IMG_WIDTH, IMG_HEIGHT, 30, 72.0)
    samples = poisson_sampling.get_samples()
    for sample in samples:
        i = random.choice(doodles)
        # load and convert
        overlay = Image.open(path.join(DOODLES_DIR, i))
        overlay.convert("RGBA")

        # alpha
        alpha = overlay.split()[3]
        alpha = ImageEnhance.Brightness(alpha).enhance(0.4)
        overlay.putalpha(alpha)

        # rotate
        overlay = overlay.rotate(random.randrange(0, 360), expand=True)

        # scale down
        scale_down_factor = 0.035
        w, h = (
            int(overlay.width * scale_down_factor),
            int(overlay.height * scale_down_factor),
        )
        overlay = overlay.resize((w, h), Image.Resampling.LANCZOS)

        # blend
        background.paste(overlay, (int(sample[0]), int(sample[1])), overlay)

    # border
    # background = ImageOps.expand(
    #     background, border=BORDER_WITDH, fill=PRIMARY_TEXT_COLOR
    # )

    # drawable
    draw = ImageDraw.Draw(background)

    # title text
    draw.text(
        (BORDER_WITDH * 12, BORDER_WITDH * 10),
        text,
        fill=PRIMARY_TEXT_COLOR,
        font=FONT_TITLE,
    )

    # subtext
    author_bound_box = draw.textbbox((0, 0), AUTHOR_TEXT, font=FONT_SUBTEXT)
    subtext_text_width = author_bound_box[2] - author_bound_box[0]
    subtext_text_height = author_bound_box[3] - author_bound_box[1]
    y = IMG_HEIGHT - (subtext_text_height * 2) - 15
    x = IMG_WIDTH - subtext_text_width - 25
    draw.text(
        (x, y),
        AUTHOR_TEXT,
        fill=SECONDARY_TEXT_COLOR,
        font=FONT_SUBTEXT,
    )

    return background


if len(sys.argv) < 2:
    print('Title not given, maybe run `make generate_thumbnail TITLE="A title"`')
    sys.exit(-1)

title = sys.argv[1]
if len(title) < 1:
    print("empty title")
    sys.exit(0)
out_title = title.lower().replace(" ", "-") + ".png"
img = create_image(title)
img.save(out_title)
print(f"Generated: {out_title}")
