predicates
nondeterm
makan(symbol,symbol)%mendeklasikan bahwa makan terisi dengan symbol symbol serta memberitahukan mempunya lebih dari 1 kemungkinan
minum(symbol,symbol)
gendut(symbol)
kekar(symbol)
kenyang(symbol,symbol)
tambah(symbol,symbol)
lapar(symbol,symbol)
clauses
makan(jalil,nasi). %jalil makan nasi
makan(andi,popmie).% andi makan popmie
makan(mahathir,soto).% mahathir makan soto
minum(jalil,jus).%jalil minum jus
minum(andi,susu).% andi minum susu
minum(mahathir,air_putih).%mahathir minum air putih
gendut(jalil).%jalil orang yang gendut
gendut(andi).%andi orang yang gendut
kekar(mahathir).%mahathir orang yang kekar
lapar(andi,lagi).%andi lapar lagi
lapar(jalil,lagi).%jalil lapar lagi
lapar(mahathir,lagi).% mahathir lapar lagi

tambah(X,Y):- minum(Y,X),gendut(X). % ada aturan yang bisa tambah makan X dan Y dan minum X dan Y serta menunjukkan X adalah orang yang gendut
kenyang(X,Y):- minum(Y,X),gendut(X).% ada aturan yang kenyang setelah makan X dan Y dan minum X dan Y serta menunjukkan X adalah orang yang gendut

goal
kenyang(_,jalil).%goalnya untuk menunjukkan bahwa yang kenyang bukanlah jalil