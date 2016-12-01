# HowTo

1. Make "data" directory:
 $ mkdir data

2. Get a seed user (anyone OK):
 $ ./4oty.pl http://4oty.net/2016/user/sweetpotato14 >data/sweetpotato14.tsv

3. Track neighbor users from the seed user:
 $ ./4otytrack.sh

4. Make ranking:
 $ ./4otyranking_new.sh
 $ ./4otyranking_cont.sh
