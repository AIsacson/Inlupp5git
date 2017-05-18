UPDATE edition
SET translations = XMLQUERY('copy $res := $t
				 			 modify insert node element Translation {attribute Language {"Norwegian"},
				 									   			   attribute Publisher {"KLC"},
				 									               attribute Price {200}} as last into $res/Translations
							 return $res'
							 PASSING translations AS "t" RETURNING CONTENT)
WHERE year IN (SELECT max(year)
               FROM edition
               WHERE book IN (SELECT id
                              FROM book
                              WHERE title = 'Encore une fois'))
                              
AND book IN (SELECT id
                              FROM book
                              WHERE title = 'Encore une fois');