create index idx_ratings_rating on ratings (movie_id, rating);
create index idx_movie_tags_cover on movie_tags (tag_id, movie_id);
create index idx_movie_genres_cover on movie_genres (genre_id, movie_id);
