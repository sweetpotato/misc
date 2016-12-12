# HowTo

1. Make "data" directory:
 $ mkdir data

2. Get a seed user (anyone OK):
 $ ./4oty.pl http://4oty.net/2016/user/sweetpotato14 >data/sweetpotato14.tsv

3. Track neighbor users from the seed user:
 $ ./track.sh

4. Make ranking:
 $ ./ranking_new.sh
 $ ./ranking_cont.sh

5. Show co-occurence:
 $ ./cooccur_new.sh 4832254839
 $ grep ^newbook_ data/sweetpotato14.tsv | cut -f3 | xargs ./cooccur_new.sh
