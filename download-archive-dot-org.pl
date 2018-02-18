#!/usr/bin/python2.5
 
#Copyright(c)2008 Internet Archive. Software license GPL version 3.
 
# This script downloads the OCR results for the Internet Archive's 
# Bioversity Heritage Library collection. It is meant to show you how to 
# download large datasets from archive.org.
 
# The csv file that drives the downloader can be fetched using the url below. 
# Change the collection parameter in the url to americana or toronto to get the
# bulk of the Internet Archive's scanned books. The advanced search page
# can help you tune the query string for accessing the rest of the collection:
# http://www.archive.org/advancedsearch.php
 
# Multiple downloaders can be run at the same time using the startnum and endnum
# parameters, which will help to speed up the download process.
 
import csv
import os
import commands
import sys
 
csvfile = "biodiversity.csv"
#download biodiveristy.csv with
#wget 'http://www.archive.org/advancedsearch.php?q=collection%3A%28biodiversity%29+AND+format%3A%28djvu+xml%29&fl%5B%5D=identifier&rows=1000000&fmt=csv&xmlsearch=Search'
 
 
startnum = 0
endnum   = 999999
 
reader = csv.reader(open(csvfile, "rb"))
reader.next() #the first row is a header
 
for i in range(startnum):
    reader.next()
 
filenum = startnum
 
for row in reader:
    id = row[0]
    dirnum = "%09d"%filenum
    print "downloading file #%s, id=%s" % (dirnum, id)
 
    #place 1000 items per directory
    assert filenum<1000000
    parentdir = dirnum[0:3]
    subdir    = dirnum[3:6]
    path = '%s/%s' % (parentdir, subdir)
 
    if not os.path.exists(path):
        os.makedirs(path)
 
 
    url = "http://www.archive.org/download/%s/%s_djvu.xml" % (id, id)
    dlpath = "%s/%s_djvu.xml"%(path, id)
 
    if not os.path.exists(dlpath):
        #urllib.urlretrieve(url, dlpath)
        #use rate limiting to be nicer to the cluster
        (status, output) = commands.getstatusoutput("""wget '%s' -O '%s' --limit-rate=250k --user-agent='IA Bulk Download Script' -q""" % (url, dlpath))
        assert 0 == status
    else:
        print "\talready downloaded, skipping..."
 
    filenum+=1
    if (filenum > endnum):
        sys.exit()
