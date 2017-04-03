/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  
 FileName: CH06E07.PRO
 Purpose: 
 Written by: PDC
 Modifyed by: Eugene Akimov
 Comments: 
******************************************************************************/

predicates
  factorial(unsigned,real) - determ (i,o)
  factorial_aux(unsigned,real,unsigned,real) - determ (i,o,i,i)

/* Numbers likely to become large are declared as reals. */

clauses
  factorial(N,FactN):- 
	factorial_aux(N,FactN,1,1.0). % Untuk Mendapatkan Nilai FactN Ada Kondisi Pada Factorial_aux, nilai 1.0 merupakan nilai real dari 1.
	
  factorial_aux(N,FactN,I,P):- % NewI = I & NewP = P
  /* 
      Nilai Ini Di Dapat Dari Factorial_Aux [ bot ] Selesai Mendapatkan Nilai I & P Dengan Mendeklarasikan Variabel Dari
      NewI = I
      NewP = P
  */
  % 3,FactN,2,1 up [ 1 ]
  % 3,FactN,3,2 up [ 2 ]
  % 3,FactN,4,6 up [ 3 ]
  
	I <= N,!, % Cut (!) Untuk Mencegah Lacak Balik Jika Nilai Sudah Tidak Terpenuhi Maka Tidak Akan Melakukan Perulangan Lagi.
		  % Jadi Pada Saat Kondisi Masih Terpenuhi Maka Masih Melakukan Perulangan.
	% 1 <= 3 [ 1 ]
	% 2 <= 3 [ 2 ]
	% 3 <= 3 [ 3 ] <- Terpenuhi 
	
	NewP = P * I,
	% NewP = 1.0 * 1 = 1 [ 1 ]
	% NewP = 1 * 2   = 2 [ 2 ]
	% NewP = 2 * 3   = 6 [ 3 ]
	
	NewI = I + 1,
	% NewI = 1 + 1   = 2 [ 1 ]
	% NewI = 2 + 1   = 3 [ 2 ]
	% NewI = 3 + 1   = 4 [ 3 ]
	
	factorial_aux(N,FactN,NewI,NewP).
	% 3,FactN,2,1 bot [ 1 ]
	% 3,FactN,3,2 bot [ 2 ]
	% 3,FactN,4,6 bot [ 3 ]

  factorial_aux(N,FactN,I,P) :-
  % 3,FactN,1,1 [ 1 ]
  % 3,FactN,3,2 [ 2 ]
  % 3,FactN,4,6 [ 3 ]
  
	I > N,
	% 1 > 3 [ 1 ]
	% 3 > 3 [ 2 ]
	% 4 > 3 [ 3 ] <- Terpenuhi Maka Dapat Mencetak Nilai Dari FactN
	FactN = P. % FactN = P / FactN = 6

goal
  factorial(3,X).