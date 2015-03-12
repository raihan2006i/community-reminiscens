SELECT "questions".*,
       ((ts_rank((to_tsvector(''simple'', coalesce("questions"."content"::text, '''')) ||
       to_tsvector(''simple'', coalesce(pg_search_9e1b.pg_search_aa7a::text, ''''))),
       (to_tsquery(''simple'', '''''' '' || ''childhood'' || '' '''''')), 0)))
       AS pg_search_rank
FROM "questions"
LEFT OUTER JOIN
  (SELECT "questions"."id" AS id,
          string_agg("themes"."name"::text, '' '') AS pg_search_aa7a
   FROM "questions"
   INNER JOIN "themes" ON "themes"."id" = "questions"."theme_id"
   GROUP BY "questions"."id") pg_search_9e1b ON pg_search_9e1b.id = "questions"."id"
WHERE ((
  (to_tsvector(''simple'', coalesce("questions"."content"::text, '''')) ||
  to_tsvector(''simple'', coalesce(pg_search_9e1b.pg_search_aa7a::text, '''')))
  @@ (to_tsquery(''simple'', '''''' '' || ''childhood'' || '' ''''''))
))
ORDER BY pg_search_rank DESC, "questions"."id" ASC, RANDOM()