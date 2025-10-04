#!/bin/zsh

python3 build_tex.py

lualatex -output-directory=build NeovimTips.tex &&
  lualatex -output-directory=build NeovimTips.tex &&
  mv build/NeovimTips.pdf book/ &&
  open book/NeovimTips.pdf

