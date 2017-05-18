SELECT XMLELEMENT(NAME "Resultat", XMLAGG(XMLELEMENT(NAME "Bok", XMLATTRIBUTES(title AS "Titel")))) AS "Resultat"
FROM book
WHERE (SELECT COUNT(book)
	   FROM edition
	   WHERE book.id = book)>1;