/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  
 FileName: CH04E13.PRO
 Purpose: 
 Written by: PDC
 Modifyed by: Eugene Akimov
 Comments: 
******************************************************************************/

predicates
  %parameternya dengan tipe data integer, karena yang akan di inputkan berupa angka
  action(integer) - nondeterm (i)

clauses
% action jika di isi angka 1, 2 & 3
% jadi jika input angka 1 maka eksekusi baris baru(nl) lalu cetak tampilan dan baris baru(nl) lagi.
  action(1):-
  	nl,
	write("You typed 1."),nl.
  action(2):-
	nl,
	write("You typed two."),nl.
  action(3):-
	nl,
	write("Three was what you typed."),nl.
  action(N):- % jika inputan selain dari angka 1,2 & 3 akan mengerluarkan output " I dont know that number".
	nl, % baris baru
	N<>1, N<>2, N<>3, % jika N Tidak dari 1, 2 & 3
	write("I don't know that number!").% output

goal
  write("Type a number from 1 to 3: "), % untuk cetak tampilan apa yang ada dalam ".
  readint(Num),% menunggu suatu inputan berupa angka/nilai 
  action(Num). % menampilkan hasil dari apa yang telah di ketikkan pada variabel Num dibagian readint sebelumnya, jadi readint jika bernilai benar akan menampilkan output dari 4 kondisi action
               % namun jika salah akan mengeluarkan output no solution, misalnya readint di isi dengan sebuah karakter, karena di readint hanya menerima inputan angka/ nilai saja bukan karakter.