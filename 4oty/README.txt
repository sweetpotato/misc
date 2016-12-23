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

5. Show co-occurence:
 $ ./cooccur.sh newbook 4832254839
 $ grep ^newbook_ data/sweetpotato14.tsv | cut -f3 | xargs ./cooccur.sh newbook

6. Others:
 $ ./ranking.sh -f 1,0 newbook
 $ ./kvotes.sh new1 483224762X
 $ ./kvotes.sh new1 4040686047

 $ ./ranking.sh -f 0,2 contbook
 $ ./kvotes.sh cont2 434483755X 4344835832
 $ ./kvotes.sh cont2 4199505245 4199504842

 $ ./ranking.sh -f 1,1 newbook
 $ ./ranking.sh -f 1,1 contbook
 $ ./kvotes.sh newcont 4434216031 4434217984
 $ ./kvotes.sh newcont 4063885631 4063886255
