-- +micrate Up
CREATE TABLE events (
  id BIGSERIAL PRIMARY KEY,
  deadline TIMESTAMP WITH TIME ZONE NOT NULL,
  title VARCHAR NOT NULL,
  memo VARCHAR,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);


-- +micrate Down
DROP TABLE IF EXISTS events;
