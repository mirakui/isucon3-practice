ALTER TABLE memos ADD INDEX idx1 (user, is_private, id);
ALTER TABLE memos ADD INDEX idx2 (is_private, id);
ALTER TABLE memos ADD COLUMN title_cache VARCHAR(200);
UPDATE memos INNER JOIN users ON users.id = memos.user SET title_cache=CONCAT('<a href="%s/memo/', memos.id, '">', SUBSTRING_INDEX(memos.content, "\n", 1), '</a> by ', users.username, ' (', memos.created_at, ' +0900)');

DROP TABLE IF EXISTS memos_warmup;
CREATE TABLE memos_warmup LIKE memos;
INSERT INTO memos_warmup SELECT * FROM memos;
DROP TABLE memos_warmup;

DROP TABLE IF EXISTS users_warmup;
CREATE TABLE users_warmup LIKE users;
INSERT INTO users_warmup SELECT * FROM users;
DROP TABLE users_warmup;
