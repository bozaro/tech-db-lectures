-- Create base schema
create table movies (
  id serial primary key,
  title text not null,
  year int,
  genres varchar(1024)
);

create table movie_tags (
  id serial primary key,
  tag_id int,
  user_id int not null,
  movie_id int not null,
  tag text not null,
  created bigint not null
);

create table ratings (
  id serial primary key,
  user_id int not null,
  movie_id int not null,
  rating float not null,
  created bigint not null
);

create table links (
  id serial primary key,
  movie_id int not null,
  imdb_id varchar(10) null,
  tmdb_id int null
);

-- Load original data
-- movies.csv: movieId,title,genres
\copy movies (id, title, genres) FROM 'ml-latest/movies.csv' WITH (DELIMITER ',', FORMAT CSV, HEADER true, ESCAPE '"', ENCODING 'UTF-8');

-- tags.csv: userId,movieId,tag,timestamp
\copy movie_tags (user_id, movie_id, tag, created) FROM 'ml-latest/tags.csv' WITH (DELIMITER ',', FORMAT CSV, HEADER true, ESCAPE '"', ENCODING 'UTF-8');
-- set created = from_unixtime(@created);

-- ratings.csv: userId,movieId,rating,timestamp
\copy ratings (user_id, movie_id, rating, created) FROM 'ml-latest/ratings.csv' WITH (DELIMITER ',', FORMAT CSV, HEADER true, ESCAPE '"', ENCODING 'UTF-8');
-- set created = from_unixtime(@created);

-- links.csv: movieId,imdbId,tmdbId
\copy links (movie_id, imdb_id, tmdb_id) FROM 'ml-latest/links.csv' WITH (DELIMITER ',', FORMAT CSV, HEADER true, ESCAPE '"', ENCODING 'UTF-8');

-- Normalize data
create table tags (
  id serial primary key,
  name text not null
);

create unique index uniq_tags_name on tags (name);

create table genres (
  id serial primary key,
  name text not null
);

create unique index uniq_genre_name on genres (name);

create table movie_genres (
  id serial primary key,
  movie_id int not null,
  genre_id int not null
);

alter table ratings
  alter column created set data type timestamptz using timestamp with time zone 'epoch' + created * interval '1 second';

insert into tags (name)
select distinct tag from movie_tags;

update movie_tags
set tag_id = t.id
from tags t
where tag = t.name;

alter table movie_tags
  alter column tag_id set not null,
  drop column tag,
  alter column created set data type timestamptz using timestamp with time zone 'epoch' + created * interval '1 second';

insert into genres (name)
select distinct unnest(string_to_array(genres,'|')) from movies 
where genres <> '(no genres listed)';

insert into movie_genres (movie_id, genre_id)
select m.id, g.id from (
  select id, unnest(string_to_array(genres,'|')) as genre from movies 
  where genres <> '(no genres listed)'
) m
join genres g on (m.genre = g.name);

update movies set year = cast(substring(title from '\(((20|19|18)\d{2})\)\s*$') as int);
update movies set title = substring(title from '^(.*?)\s*\((20|19|18)\d{2}\)\s*$') where year is not null;

alter table movies
  drop column genres;

alter table links
  add constraint fk_movie_id foreign key (movie_id) references movies (id);

alter table movie_genres
  add constraint fk_movie_id foreign key (movie_id) references movies (id),
  add constraint fk_genre_id foreign key (genre_id) references genres (id);

alter table movie_tags
  add constraint fk_movie_id foreign key (movie_id) references movies (id),
  add constraint fk_tag_id foreign key (tag_id) references tags (id);

alter table ratings
  add constraint fk_movie_id foreign key (movie_id) references movies (id);

vacuum full;
