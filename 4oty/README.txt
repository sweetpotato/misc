# HowTo

1. Make "data" directory:
 $ mkdir data

2. Get a seed user (anyone OK):
 $ ./4oty.pl http://4oty.net/2016/user/sweetpotato14 >data/sweetpotato14.tsv

3. Track neighbor users from the seed user:
 $ ./track.sh

4. Make ranking:
 $ ./ranking.sh newbook >ranking_new.txt
 $ ./ranking.sh contbook >ranking_cont.txt
 $ ./ranking.sh -f 1,0 newbook >ranking_1_0_new.txt
 $ ./ranking.sh -f 0,2 contbook >ranking_0_2_cont.txt

5. Show co-occurence:
 $ ./cooccur_new.sh 4832254839
 $ grep ^newbook_ data/sweetpotato14.tsv | cut -f3 | xargs ./cooccur_new.sh

6. Other one-liners:

 $ grep -h ^newbook_ data/*.tsv | awk -F$'\t' '{print $5;}' | sed -r -e 's!https?://[-_a-zA-Z0-9./?%]+!!g' -e 's/^\s+|\s+$//g' | perl -CS -ne 'chomp;print length($_),"\n"' | sort -n >nchars_new.txt

 $ grep -h ^contbook data/*.tsv | awk -F$'\t' '{print $5;}' | sed -r -e 's!https?://[-_a-zA-Z0-9./?%]+!!g' -e 's/^\s+|\s+$//g' | perl -CS -ne 'chomp;print length($_),"\n"' | sort -n >nchars_cont.txt

 $ grep -c -e 434483755X -e 4344835832 data/*.tsv | awk -F: '$2=="2"{print $1;}' | xargs grep -c ^contbook | awk -F: '$2=="2"{print $1;}' | xargs grep -c ^newbook_ | awk -F: '$2=="0"{print $1;}' | xargs grep -v ^neighbor

 $ grep -c -e 4199505245 -e 4199504842 data/*.tsv | awk -F: '$2=="2"{print $1;}' | xargs grep -c ^contbook | awk -F: '$2=="2"{print $1;}' | xargs grep -c ^newbook_ | awk -F: '$2=="0"{print $1;}' | xargs grep -v ^neighbor

 $ grep -l 4434216031 data/*.tsv | xargs grep -c ^newbook_ | awk -F: '$2=="1"{print $1;}' | xargs grep -l 4434217984 | xargs grep -c ^contbook | awk -F: '$2=="1"{print $1;}' | xargs grep -v ^neighbor

 $ grep -l 4063885631 data/*.tsv | xargs grep -c ^newbook_ | awk -F: '$2=="1"{print $1;}' | xargs grep -l 4063886255 | xargs grep -c ^contbook | awk -F: '$2=="1"{print $1;}' | xargs grep -v ^neighbor

 $ grep -l 483224762X data/*.tsv | xargs grep -c ^newbook_ | awk -F: '$2=="1"{print $1;}' | xargs grep -c ^contbook | awk -F: '$2=="0"{print $1;}' | xargs grep -v ^neighbor

 $ grep -l 4040686047 data/*.tsv | xargs grep -c ^newbook_ | awk -F: '$2=="1"{print $1;}' | xargs grep -c ^contbook | awk -F: '$2=="0"{print $1;}' | xargs grep -v ^neighbor
