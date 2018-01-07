/*
 * 1. Import base data.
 */
CREATE TABLE user(
    id    TEXT NOT NULL PRIMARY KEY,
    name  TEXT NOT NULL);

CREATE TABLE title(
    id    TEXT NOT NULL PRIMARY KEY,
    name  TEXT NOT NULL);

CREATE TABLE newbook(
    user_id   TEXT NOT NULL,
    title_id  TEXT NOT NULL,
    desc      TEXT NOT NULL,
    PRIMARY KEY(user_id,title_id),
    FOREIGN KEY(user_id)  REFERENCES user(id),
    FOREIGN KEY(title_id) REFERENCES title(id));

CREATE TABLE contbook(
    user_id   TEXT NOT NULL,
    title_id  TEXT NOT NULL,
    desc      TEXT NOT NULL,
    PRIMARY KEY(user_id, title_id),
    FOREIGN KEY(user_id)  REFERENCES user(id),
    FOREIGN KEY(title_id) REFERENCES title(id));

.separator "\t"
.nullvalue "THISISNULLVALUENOBODYLIKELYUSE"

.import   user.tsv      user
.import   title.tsv     title
.import   newbook.tsv   newbook
.import   contbook.tsv  contbook

-- BUG FIX
BEGIN;
-- general fix: trim Amazon URL
UPDATE title SET id=TRIM(id);
UPDATE newbook SET title_id=TRIM(title_id);
UPDATE contbook SET title_id=TRIM(title_id);
-- BUG FIX DONE
COMMIT;

/*
 * 2. Make summary.
 */
CREATE VIEW newbook_summary AS
SELECT LENGTH(desc)>0 AS has_comment, COUNT(*) AS n_votes
FROM newbook -- HERE is diff
GROUP BY has_comment;
-- ORDER BY has_comment DESC;

CREATE VIEW contbook_summary AS
SELECT LENGTH(desc)>0 AS has_comment, COUNT(*) AS n_votes
FROM contbook -- HERE is diff
GROUP BY has_comment;
-- ORDER BY has_comment DESC;

CREATE VIEW newbook_histogram AS
SELECT (LENGTH(desc)+9)/10*10 AS n_chars, COUNT(*) AS n_votes
FROM newbook -- HERE is diff
WHERE n_chars>0 GROUP BY n_chars;
-- ORDER BY n_chars ASC;

CREATE VIEW contbook_histogram AS
SELECT (LENGTH(desc)+9)/10*10 AS n_chars, COUNT(*) AS n_votes
FROM contbook -- HERE is diff
WHERE n_chars>0 GROUP BY n_chars;
-- ORDER BY n_chars ASC;

CREATE VIEW user_summary AS
SELECT
  IFNULL(nbook.len,0)+IFNULL(cbook.len,0) AS c_sum,
  IFNULL(nbook.len,0) AS c_new,
  IFNULL(cbook.len,0) AS c_cont,
  IFNULL(nbook.cnt,0)+IFNULL(cbook.cnt,0) AS n_sum,
  IFNULL(nbook.cnt,0) AS n_new,
  IFNULL(cbook.cnt,0) AS n_cont,
  user.id AS id,
  user.name AS name
FROM user
LEFT OUTER JOIN(
  SELECT user_id, COUNT(*) AS cnt, SUM(LENGTH(desc)) AS len
  FROM newbook GROUP BY user_id)
  AS nbook ON user.id=nbook.user_id
LEFT OUTER JOIN(
  SELECT user_id, COUNT(*) AS cnt, SUM(LENGTH(desc)) AS len
  FROM contbook GROUP BY user_id)
  AS cbook ON user.id=cbook.user_id;
-- ORDER BY
-- c_sum DESC, c_new DESC, c_cont DESC,
-- n_sum DESC, n_new DESC, n_cont DESC,
-- id ASC;

CREATE VIEW user_comment_summary AS
SELECT c_sum>0 AS do_comment, COUNT(*) AS n_users
FROM user_summary GROUP BY do_comment;
-- ORDER BY do_comment DESC;

CREATE VIEW user_comment_histogram AS
SELECT (c_sum+99)/100*100 AS n_chars, COUNT(*) AS n_users
FROM user_summary WHERE n_chars>0 GROUP BY n_chars;
-- ORDER BY n_chars ASC;

CREATE TABLE newbook_aggregate(
    title_id    TEXT NOT NULL PRIMARY KEY,
    is_kirara   INTEGER NOT NULL,
    n_users     INTEGER NOT NULL,
    n_chars     INTEGER NOT NULL,
    histogram   TEXT,
    FOREIGN KEY(title_id) REFERENCES title(id),
    CHECK(n_users>0));

CREATE TABLE contbook_aggregate(
    title_id    TEXT NOT NULL PRIMARY KEY,
    is_kirara   INTEGER NOT NULL,
    n_users     INTEGER NOT NULL,
    n_chars     INTEGER NOT NULL,
    histogram   TEXT,
    FOREIGN KEY(title_id) REFERENCES title(id),
    CHECK(n_users>0));

INSERT INTO newbook_aggregate
SELECT
  id,
  CASE WHEN id LIKE '%/dp/483224%' THEN 1 ELSE 0 END,
  book.cnt,
  book.len,
  CASE WHEN book.cnt=1 THEN CAST(book.len AS TEXT) || ';' ELSE NULL END
FROM title
INNER JOIN(
  SELECT title_id, COUNT(*) AS cnt, SUM(LENGTH(desc)) AS len
  FROM newbook -- HERE is diff
  GROUP BY title_id)
  AS book ON title.id=book.title_id;

INSERT INTO contbook_aggregate
SELECT
  id,
  CASE WHEN id LIKE '%/dp/483224%' THEN 1 ELSE 0 END,
  book.cnt,
  book.len,
  CASE WHEN book.cnt=1 THEN CAST(book.len AS TEXT) || ';' ELSE NULL END
FROM title
INNER JOIN(
  SELECT title_id, COUNT(*) AS cnt, SUM(LENGTH(desc)) AS len
  FROM contbook -- HERE is diff
  GROUP BY title_id)
  AS book ON title.id=book.title_id;

CREATE VIEW newbook_ranking AS
SELECT
  CASE B.is_kirara WHEN 1 THEN 'K' ELSE '-' END AS kirara,
  B.n_users AS n_users, B.n_chars AS n_chars,
  B.title_id AS link, T.name AS title, B.histogram AS histogram
FROM newbook_aggregate B -- HERE is diff
INNER JOIN title T ON B.title_id=T.id;
-- ORDER BY n_users DESC, n_chars DESC, link DESC;

CREATE VIEW contbook_ranking AS
SELECT
  CASE B.is_kirara WHEN 1 THEN 'K' ELSE '-' END AS kirara,
  B.n_users AS n_users, B.n_chars AS n_chars,
  B.title_id AS link, T.name AS title, B.histogram AS histogram
FROM contbook_aggregate B -- HERE is diff
INNER JOIN title T ON B.title_id=T.id;
-- ORDER BY n_users DESC, n_chars DESC, link DESC;

/*
 * 3. Update histogram of {newbook,contbook}_aggregate.
 *
 * (Run update_histogram script.)
 */
