#!/bin/bash

bgcolor="#123646"

convert source.png -format png -background "${bgcolor}" -flatten tape.png

etc1tool tape.png
