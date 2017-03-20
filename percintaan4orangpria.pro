domains
mencintai,cemburu = symbol
predicates
nondeterm mencintai(symbol,symbol)
nondeterm cemburu_buta(symbol,symbol)
clauses
mencintai(andi,oliv).
mencintai(jalil,oliv).
mencintai(mahathir,dia).
mencintai(chrisman,dia).%NB : dia merupakan nama seorang gadis, Anggap Saja Begitu
mencintai(jalil,dia).
mencintai(andi,dia).
cemburu_buta(Nama1,Nama2):-
	mencintai(Nama1,Nama3),mencintai(Nama2,Nama3).
cemburu_buta(Nama1,Nama3):-
	mencintai(Nama1,Nama2),mencintai(Nama2,Nama3).
goal
 mencintai(andi,SiCewek).