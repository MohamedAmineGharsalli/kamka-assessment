CREATE TABLE IF NOT EXISTS todos (
  id   SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  done  BOOLEAN DEFAULT false
);
INSERT INTO todos (title) VALUES ('Lire les instructions KAMKA');
INSERT INTO todos (title) VALUES ('Dockeriser l app');
INSERT INTO todos (title) VALUES ('Configurer le pipeline CI/CD');
