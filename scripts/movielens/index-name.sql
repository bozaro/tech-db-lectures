create index idx_movies_title on movies (lower(title) text_pattern_ops);
create index idx_genres_name on genres (lower(name) text_pattern_ops);
create index idx_tags_name on tags (lower(name) text_pattern_ops);