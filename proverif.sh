#!/bin/sh
FILES_DIR=$( pwd )
docker run --rm -v "$FILES_DIR":/data koenyskout/proverif:default proverif $@