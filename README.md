# Dutch Medical Wikipedia

This repository documents how to download the dutch medical wikipedia.

#### 1. Download all Dutch wikipedia articles
Dump file location: https://dumps.wikimedia.org/nlwiki

Wikipedia dump files are updated twice per month. Old versions are removed. It is recommended to use download the latest
version, and include the file name in the download. For example, browse to `20200920/` and download 
`nlwiki-20200920-pages-articles.xml.bz2` which is around 1.4GB.

There are also versions of the dump that are separated into separate files so that it is more suitable for parallel
processing. This can cause some [issues](https://github.com/attardi/wikiextractor/issues/61) so it's recommended to 
use the complete `-pages-articles.xml.bz2` file.

#### 2. Download the medical categories
You can use the included `categories_geneeskunde_depth4.txt` file for this, or download the categories yourself using
the following steps.

To select all medical Wikipedia articles, we use the top category for medical articles. In Dutch this is 
"Geneeskunde". However most dutch medical articles contain a more specific category, such as "Neurological condition" or
"Cancer". Therefore, we use Wikipedia's Petscan to retrieve all categories that are related to the "Geneeskunde"
 category.  

1. Go to https://petscan.wmflabs.org
2. Select language `nl`
3. Select depth `4`. If you set depth too low, you will miss articles, but if it's set too high, you will include many false
positives. After testing a few different categories, I think depth 4 is most accurate while having a good coverage. Note
that Wikipedia categories are in a graph structure, not a tree structure.
4. Select the Page Properties tab, and make sure only "Categorie" Namespace is checked.
5. Press `Do it!`. This resulted in 841 categories on October 13, 2020.
6. Copy all categories to a `.txt` file. I did this by selecting the categories and copy/paste/reformat them using Atom 
and Excel. I saved it as `categories_geneeskunde_depth4.txt` and included it in this repository. Make sure the special
characters are copied correctly. When I downloaded the categories directly as CSV, there were errors in copyting the
special characters.
- Copy all resulting category names to a text file, such as `categories_geneeskunde_depth4`. I did this by copy pasting the website data to Atom, to Excel, and then copy the correct values to a txt. When exporting to csv first, the special characters were copied incorrectly. 

### 3. Download Wikiextractor
WikiExtractor is used extract all articles from the relevant categories. There were some issues with the latest stable
release at the time of writing this document, and some fixes were necessary to correctly extract the categories, and 
make the code work with Dutch Wikipedia. Therefore, we use a fork of WikiExtractor in this project.

```bash
git clone -b stable_dutch --single-branch https://github.com/sandertan/wikiextractor/
```

TODO: Add fixes and customizable category to main repository. 

### 4. Configure bash script to handle extracting and file naming
This is based on a [Medium article](https://towardsdatascience.com/pre-processing-a-wikipedia-dump-for-nlp-model-training-a-write-up-3b9176fdf67).

Paths to set in `extract_and_clean_wiki_dump.sh` for your downloaded dump files and :
```bash
WIKI_DUMP_FILE_IN=nlwiki-20200901-pages-articles.xml.bz2
WIKI_DUMP_FILE_OUT=nlwiki_20200901_geneeskunde_depth4.txt
CATEGORIES_FILE=categories_geneeskunde_depth4.txt
```

### 5. Execute bash script
```bash
bash extract_and_clean_wiki_dump.sh
```

This process takes about 20 minutes using 4 cores.

  

