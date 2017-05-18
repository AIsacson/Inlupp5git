SELECT XMLELEMENT(NAME "Resultat", XMLAGG(xt))
FROM (SELECT XMLELEMENT(NAME "Förlag",XMLATTRIBUTES(name AS "Namn", country AS "Land"),
			 XMLAGG(XMLELEMENT(NAME "Bok", XMLATTRIBUTES(title AS "Titel", genre AS "Genre")))) AS xt
      FROM publisher, book
      WHERE publisher.name IN (SELECT pub."publisher"
                               FROM edition, XMLTABLE('distinct-values($t//Translation/@Publisher)'
                                                       PASSING translations AS "t"
                                                       COLUMNS "publisher" VARCHAR(25) PATH 'string()') AS pub
                               WHERE book.id = edition.book)
      GROUP BY name, country);