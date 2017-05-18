SELECT name AS "Namn", XMLQUERY('$i//Country/text()' PASSING info AS "i"  RETURNING CONTENT) AS "Land"
FROM author
WHERE id IN (SELECT author
	     FROM authorship
	     WHERE book IN (SELECT id
			    FROM book
			    WHERE id IN (SELECT book
			 		 FROM edition
			 		 WHERE XMLEXISTS('$t//Translation[@Language="Russian"]'
                                     			  PASSING translations AS "t"))))
