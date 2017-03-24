create index idx_links_movie_id on links (movie_id);
create index idx_movie_genres_movie_id on movie_genres (movie_id);
create index idx_movie_genres_genre_id on movie_genres (genre_id);

create index idx_movie_tags_movie_id on movie_tags (movie_id);
create index idx_movie_tags_tag_id on movie_tags (tag_id);

create index idx_ratings_movie_id on ratings (movie_id);
