# HowTo

1. Make "data" directory:
 $ mkdir data

2. Get a seed user (anyone OK):
 $ ./fetch_user.sh sweetpotato14

3. Track neighbor users from the seed user:
 $ ./track.sh

4. Make ranking:
 $ ./ranking.sh newbook >ranking_new.txt
 $ ./ranking.sh contbook >ranking_cont.txt

5. Show co-occurence:
 $ ./cooccur.sh newbook 4832254839
 $ grep ^newbook_ data/sweetpotato14.tsv | cut -f3 | xargs ./cooccur.sh newbook

6. Make crosstab:
 $ ./crosstab.sh >crosstab.tsv

For drawing bar chart, import crosstab.tsv to spreadsheet.

7. Count votes by publisher
 $ ./publisher.sh newbook >pub_new.tsv
 $ ./publisher.sh -s newbook >sub_new.tsv
 $ ./publisher.sh contbook >pub_cont.tsv
 $ ./publisher.sh -s contbook >sub_cont.tsv

For drawing donut chart, import a pair of pub/sub to spreadsheet like this:

  |   A   |   B   |   C   |   D   |
 -+-------+-------+-------+-------+
 1|  48322|       |       |    844|
 2|(48322)| 483224|    600|       |
 3|(48322)| 483225|    244|       |
 4|    404|       |       |    312|
 5|  (404)|  40406|    207|       |
 6|  (404)| others|    105|       |
 7|  48019|       |  [129]|    129|
 8|  47580|       |   [73]|     73|
 :|      :|      :|      :|      :|

Here, each number in (parentheses) should be deleted, and each number in
[brackets] should refer to the neighboring cell on the right-hand side.

8. Others:
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
