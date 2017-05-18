SELECT XMLELEMENT(NAME "Resultat", XMLAGG(xt))
FROM(SELECT XMLELEMENT(NAME "Förlag", XMLATTRIBUTES(name AS "namn", country AS "land"),
													 XMLAGG(XMLELEMENT(NAME "Språk", sprak))) AS xt
	 FROM publisher, (SELECT DISTINCT sprak, forlag
				 	  FROM edition, XMLTABLE('$t//Translation' PASSING translations AS "t"
						 	   COLUMNS sprak VARCHAR(25) PATH '@Language',
								 	   forlag VARCHAR(25) PATH '@Publisher') AS s)
WHERE forlag = publisher.name
GROUP BY name, country ORDER BY name);