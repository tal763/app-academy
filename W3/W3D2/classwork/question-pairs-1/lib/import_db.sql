DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);

DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id)
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

DROP TABLE IF EXISTS replies;

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  body TEXT NOT NULL ,
  question_id INTEGER NOT NULL,
  parent_id INTEGER NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id)
  FOREIGN KEY (parent_id) REFERENCES replies(id)
  FOREIGN KEY (user_id) REFERENCES users(id)

);

DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id)
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  users(fname, lname)
VALUES
  ('John', 'Smith'),
  ('James', 'Santos'),
  ('Tanner', 'Lane');

INSERT INTO
  questions(title, body, user_id)
VALUES
  ('im confused', 'plz help', (SELECT id FROM users WHERE fname='James' AND lname='Santos')),
  ('Does this work', 'Is this merge sort better than Kelly''s?', 3);

INSERT INTO
  question_follows(user_id, question_id)
VALUES
  (2, 1);

INSERT INTO
  replies(body, question_id, parent_id, user_id)
VALUES
  ('Read the documentation, please.', 1, NULL, 2),
  ('I can''t read.', 1, 1, 2);

INSERT INTO
  question_likes(user_id, question_id)
VALUES
  (3, 1);
