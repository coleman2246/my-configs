#!/bin/bash

FORCE="$1"
SYNTAX="$2"
EXTENSION="$3"
OUTPUTDIR="$4"
INPUT="$5"
CSSFILE="$6"

FILE=$(basename "$INPUT")
FILENAME=$(basename "$INPUT" .$EXTENSION)
FILEPATH=${INPUT%$FILE}
OUTDIR=${OUTPUTDIR%$FILEPATH*}
OUTPUT="$OUTPUTDIR"/$FILENAME
CSSFILENAME=$(basename "$6")

HAS_MATH=$(grep -o "\$\$.\+\$\$" "$INPUT")
if [ ! -z "$HAS_MATH" ]; then
    MATH="--mathjax=https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"
else
    MATH=""
fi

#sed -r 's/(\[.+\])\(([^)]+)\)/\1(\2.html)/g' <"$INPUT" | pandoc $MATH -s -f $SYNTAX -t html -c $CSSFILENAME --metadata title="$FILE" >"$OUTPUT.$EXTENSION.html"
if [[ "$EXTENSION" == "md" || "$EXTENSION" == "markdown" ]]; then
  sed -r 's/(\[.+\])\(([^)]+)\)/\1(\2.html)/g' <"$INPUT" | \
  pandoc $MATH -s -f "$SYNTAX" -t html -c "$CSSFILENAME" --metadata title="$FILE" >"$OUTPUT.$EXTENSION.html"
else
  cat "$INPUT" | \
  pandoc $MATH -s -f "$SYNTAX" -t html --metadata title="$FILE" >"$OUTPUT..html"
fi

