SELECT XMLELEMENT(NAME "Alla", XMLAGG(xl))
FROM (SELECT XMLELEMENT(NAME "Författare", XMLATTRIBUTES(author.name AS "Namn", "land" AS "Land"), 
		XMLAGG(XMLELEMENT(NAME "Bok", XMLATTRIBUTES(title AS "Title", originallanguage AS "Originalspråk", genre AS "Genre"))))AS xl
	  FROM book, author, XMLTABLE('$i//Country' 
PASSING info AS "i" COLUMNS "land" VARCHAR(25) PATH 'text()')
	  WHERE author.id IN (SELECT author
					FROM authorship
					WHERE book = book.id)
	  GROUP BY name, "land")