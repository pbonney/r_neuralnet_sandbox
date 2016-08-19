SELECT
  CASE
    WHEN p.term_pitch=0 THEN 0
    WHEN a.event in ("Single", "Double", "Triple", "Home Run") THEN 1
    ELSE 0
  END AS outcome,
  p.px,
  p.pz
FROM
  pitches p,
  atbats a
WHERE a.gameName = p.gameName
AND a.num = p.gameAtBatId
AND substr(a.gameName, 5, 4) = "2016"
AND substr(a.gameName, 10, 2) = "08"
AND p.px IS NOT NULL
AND p.pz IS NOT NULL
;
