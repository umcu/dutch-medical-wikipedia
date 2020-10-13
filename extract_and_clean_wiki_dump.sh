#!/bin/sh
set -e

# Set file names
WIKI_DUMP_FILE_IN=nlwiki-20200901-pages-articles.xml.bz2
WIKI_DUMP_FILE_OUT=nlwiki_20200901_geneeskunde_depth4.txt
CATEGORIES_FILE=categories_geneeskunde_depth4.txt

# extract and clean the chosen Wikipedia dump
echo "Extracting and cleaning $WIKI_DUMP_FILE_IN to $WIKI_DUMP_FILE_OUT..."
python3 wikiextractor/WikiExtractor.py $WIKI_DUMP_FILE_IN --processes 4 --filter_category $CATEGORIES_FILE -o - \
| sed "/^\s*\$/d" \
| grep -v "^<doc id=" \
| grep -v "</doc>\$" \
> $WIKI_DUMP_FILE_OUT
echo "Succesfully extracted and cleaned $WIKI_DUMP_FILE_IN to $WIKI_DUMP_FILE_OUT"
