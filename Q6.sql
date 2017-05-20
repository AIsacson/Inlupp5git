SELECT title AS "Titel", originallanguage AS "Originalspråk", genre AS "Genre",
                                                              (SELECT COUNT(*)
                                                               FROM edition
                                                               WHERE book = book.id) AS "AntalUpplagor",
                                                              (SELECT COUNT(DISTINCT sprak)
                                                               FROM edition, XMLTABLE('$t//Translation' PASSING translations AS "t" COLUMNS sprak VARCHAR(25) PATH '@Language') AS s
                                                               WHERE book = book.id) AS "AntalSpråk",
                                                              (SELECT COUNT(DISTINCT id)
                                                               FROM author
                                                               WHERE id IN (SELECT author
                                                                            FROM authorship
                                                                            WHERE book IN (SELECT book.id
                                                                                           FROM edition
	    						                                                                         WHERE book = book.id))) AS "AntalFörfattare",
                                                              (SELECT min(year)
                                                               FROM edition
                                                               WHERE book = book.id) AS "År"
FROM book;
