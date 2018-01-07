# HowTo

1. Make "data" directory:
 $ mkdir -p data

2. Get seed users (anyone, any number OK):
 $ ./11_fetch_user.sh sweetpotato14

3. Track neighbors from current user set:
 $ ./12_track.sh

To update existing users, you should give -f option.

4. Make ranking:
 $ ./13_prepare_import.sh
 $ ./14_import.sh
 $ ./15_update_histogram.sh
 $ ./20_run_sql.sh 21_ranking_user.sql >ranking_user.txt
 $ ./20_run_sql.sh 22_ranking_newbook.sql >ranking_newbook.txt
 $ ./20_run_sql.sh 23_ranking_contbook.sql >ranking_contbook.txt

To remake the database, you should give -f option to script 14.

Do not open these ".txt" files *as CSV with Excel* because they are encoded
in UTF-8 while CSV files are assumed in Shift_JIS. You should open them with
"Open" menu in Excel. Note that you might set the filter to "All files".

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
