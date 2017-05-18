XQUERY
element Resultat {
for $sprak in distinct-values(ora:view("book")//ORIGINALLANGUAGE/text())
let $antal := for $bok in ora:view("book")//ORIGINALLANGUAGE
			  return $bok[text() = $sprak]
return element Språk {attribute namn {$sprak}, attribute antalböcker {count($antal)}}