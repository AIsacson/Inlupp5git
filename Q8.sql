UPDATE edition
SET translations = XMLQUERY('copy $res := $t 
                            modify replace value of node $res//Translation[@Language = "French"]/@Publisher with "ABC International"
                            return $res' PASSING translations AS "t" RETURNING CONTENT)
WHERE year = 1999
AND book IN (SELECT id
             FROM book
             WHERE title = 'Archeology in Egypt');