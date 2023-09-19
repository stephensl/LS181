CREATE TABLE stars (
  id serial PRIMARY KEY, 
  name varchar(25) UNIQUE NOT NULL, 
  distance integer NOT NULL CHECK(distance > 0), 
  spectral_type char(1) CHECK(spectral_type ~ '[OBAFGK]'),
  companions integer NOT NULL CHECK(companions >= 0)
);

CREATE TABLE planets (
  id serial PRIMARY KEY, 
  designation char(1) UNIQUE CHECK(designation ~ '[a-z]'), 
  mass integer
);