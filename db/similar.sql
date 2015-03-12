SELECT "stories".*,
       (( ts_rank((
          setweight(to_tsvector('simple', coalesce("stories"."title"::text, '')), 'A') || 
          to_tsvector('simple', coalesce(pg_search_e586.pg_search_1765::text, '')) || 
          to_tsvector('simple', coalesce(pg_search_9e1b.pg_search_aa7a::text, '')) || 
          to_tsvector('simple', coalesce(pg_search_4a09.pg_search_c897::text, ''))
          ), (to_tsquery('simple', ''' ' || 'childhood' || ' ''')), 0)
        )) AS pg_search_rank
FROM "stories"
LEFT OUTER JOIN
  (SELECT "stories"."id" AS id,
          string_agg("story_fragments"."content"::text, ' ') AS pg_search_1765
   FROM "stories"
   INNER JOIN "story_fragments" ON "story_fragments"."story_id" = "stories"."id"
   GROUP BY "stories"."id") pg_search_e586 ON pg_search_e586.id = "stories"."id"
LEFT OUTER JOIN
  (SELECT "stories"."id" AS id,
          string_agg("themes"."name"::text, ' ') AS pg_search_aa7a
   FROM "stories"
   INNER JOIN "themes" ON "themes"."id" = "stories"."theme_id"
   GROUP BY "stories"."id") pg_search_9e1b ON pg_search_9e1b.id = "stories"."id"
LEFT OUTER JOIN
  (SELECT "stories"."id" AS id,
          string_agg("contexts"."name"::text, ' ') AS pg_search_c897
   FROM "stories"
   INNER JOIN "contexts" ON "contexts"."id" = "stories"."context_id"
   GROUP BY "stories"."id") pg_search_4a09 ON pg_search_4a09.id = "stories"."id"
WHERE "stories"."teller_id" = $1
  AND (((setweight(to_tsvector('simple', coalesce("stories"."title"::text, '')), 'A') ||
  to_tsvector('simple', coalesce(pg_search_e586.pg_search_1765::text, '')) ||
  to_tsvector('simple', coalesce(pg_search_9e1b.pg_search_aa7a::text, '')) ||
  to_tsvector('simple', coalesce(pg_search_4a09.pg_search_c897::text, ''))) @@
  (to_tsquery('simple', ''' ' || 'childhood' || ' ''')))
  OR ((setweight(to_tsvector('simple',
  pg_search_dmetaphone(coalesce("stories"."title"::text, ''))), 'A') ||
  to_tsvector('simple', pg_search_dmetaphone(coalesce(pg_search_e586.pg_search_1765::text, ''))) ||
  to_tsvector('simple', pg_search_dmetaphone(coalesce(pg_search_9e1b.pg_search_aa7a::text, ''))) ||
  to_tsvector('simple', pg_search_dmetaphone(coalesce(pg_search_4a09.pg_search_c897::text, ''))))
  @@ (to_tsquery('simple', ''' ' || pg_search_dmetaphone('childhood') || ' '''))))
ORDER BY pg_search_rank DESC, "stories"."id" ASC [["teller_id", 14]]