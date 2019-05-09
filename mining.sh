# get the scientific name
grep '<h2>' * | sed -e 's/<[^>]*>//g' | sed 's/\.html\:/\,/'  > analysis/sci.res


# get the family name
grep 'Family' * | sed -e 's/<[^>]*>//g' | sed 's/Family//' | sed 's/\.html\:/\,/' | grep -v ','$ > fam.res


# get the common names
grep 'Common names' *   | sed -e 's/<[^>]*>//g' | sed 's/Common names//' | cut -d',' -f1 | grep -v ':'$ | sed 's/'.html:'/','/' > analysis/common_name.res


# get common name from notes
awk -F'COMMON NAMES'  '{print FILENAME,$2}' *.html | grep -v 'html '$ | grep -v 'html <br>' | cut -d',' -f1 | sed 's/\.html/,/' | cut -d'.' -f1 | grep -v 'FURTHER' | sed 's/://' | cut -d';' -f1 | grep -v '<br>' | sed 's/(.*)//' | sed 's/,  /,/' | sed 's/, /,/' > analysis/name_note.res


# get the auth 
 grep -i Authority  ../dataDownload/* |  sed -e 's/<[^>]*>//g'  | cut -d'/' -f 3 | sed 's/\.html\:Authority/,/' > res/auth.res


# get the extra comma in the names
 cat ecocrop_id_sci_com_fam_auth_mod.csv | sed 's/[^,]//g' > comma
 cat -n comma  |  grep  ',,,,,'
 cat -n comma  |  grep  ',,,,,,'


# extract common names 
# get all the common name in one line
grep 'Common names' * | sed 's/.html:<th class="label">Common names<\/th><td>/,/' | grep -v ',<\/td>'$ | sed 's/<\/td>//' > ../analysis/res/all_comm.res

# repeat the cropid in each line
 awk -F',' '{gsub(",","_"$1",",$0); print $0}' all_comm.res | sed 's/_/\n/g' | sed 's/, /,/' | grep ',' > all_comm.csv

# get the synonym 
 grep 'Synonyms<' * | sed 's/.html:<th class="label">Synonyms<\/th><td>/,/' | grep -v ',<\/td>'$ | sed 's/<\/td>//'  > ../analysis/res/all_Synonyms


 awk -F',' '{gsub(",","_"$1",",$0); print $0}' all_Synonyms |  sed 's/_/\n/g' | sed 's/, /,/' | grep ',' | sed 's/&amp;//g' > all_Synonyms.csv

