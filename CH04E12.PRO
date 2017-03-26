/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  
 FileName: CH04E12.PRO
 Purpose: 
 Written by: PDC
 Modifyed by: Eugene Akimov
 Comments: 
******************************************************************************/

domains
  name,sex,occupation,object,vice,substance = symbol
  age=integer

predicates
  person(name,age,sex,occupation) - nondeterm (o,o,o,o), nondeterm (i,o,o,i), nondeterm (i,o,i,o)
  had_affair(name,name) - nondeterm (i,i), nondeterm (i,o)
  killed_with(name,object) - determ (i,o)
  killed(name) - procedure (o)
  killer(name) - nondeterm (o)
  motive(vice) - nondeterm (i)
  smeared_in(name,substance) - nondeterm (i,o), nondeterm (i,i)
  owns(name,object) - nondeterm (i,i)
  operates_identically(object,object) - nondeterm (o,i)
  owns_probably(name,object) - nondeterm (i,i)
  suspect(name) - nondeterm (i)

/* * * Facts about the murder * * */
clauses
% person disini terdapat parameter
% yang isinya Nama, Usia, Jenis Kelamin Dan Profesi.
  person(bert,55,m,carpenter).
  person(allan,25,m,football_player).
  person(allan,25,m,butcher).
  person(john,25,m,pickpocket).

% Disini Ada Beberapa Fakta Yang Menjelaskan
% Mereka Berhubungan (Asmara), Jadi Dapat Dilihat Pada Fakta Tersebut
% Bahwa Barbara & John Memiliki Hubungan dengan 2 Orang (Selingkuh).
  had_affair(barbara,john).
  had_affair(barbara,bert).
  had_affair(susan,john).

  % Susan terbunuh dengan alat club (Pemukul Bola Base ball)
  killed_with(susan,club).
  
  % Fakta Bahwa Susan Terbunuh
  killed(susan).

  % Terdapat Beberapa Motif Pembunuhan Disini
  % Ada Yang Motifnya Karena Uang, Cemburu & juga Kebenaran.
  motive(money). 
  motive(jealousy).
  motive(righteousness).

% Fakta Disini Menjelaskan Beberapa orang yang Berlumuran darah, coklat & lumpur.
  smeared_in(bert,blood). % Bert Berlumuran Darah
  smeared_in(susan,blood).% susan Berlumuran Darah
  smeared_in(allan,mud). % Allan Berlumuran Lumpur
  smeared_in(john,chocolate). % John Berlumuran Coklat
  smeared_in(barbara,chocolate).% Barbara Berlumuran Coklat

% Lalu Ada Fakta Kepemilikan
  owns(bert,wooden_leg). % Bert Memiliki kaki Kayu
  owns(john,pistol). %John Memiliki Pistol

/* * * Background knowledge * * */
% Disini Fakta Dugaan Bagaiman Cara Si Pembunuh Beraksi
% Pada Saat Kejadian Tersebut.
  operates_identically(wooden_leg, club).
  operates_identically(bar, club).
  operates_identically(pair_of_scissors, knife).
  operates_identically(football_boot, club).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%		3 KEMUNGKINAN KEPEMILIKAN	%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Kemungkinan Kepemilikan Dari Si X = Nama
  %A. X Mungkin Memiliki Sepatu Bola Jika Orang Tersebut Berprofesi Sebagai Pemain Sepakbola
  % Umur & Jenis Kelamin di Abaikan Maksudnya Apapun Umur & Jenis Kelaminnya.
  owns_probably(X,football_boot):-
	person(X,_,_,football_player).
  %B. X Mungkin Memiliki Sepasang Gunting Jika Orang Tersebut Berprofesi Sebagai Penata Rambut
  % Umur & Jenis Kelamin Di Abaikan Maksudnya Apapun umur & jenis Kelaminnya.
  owns_probably(X,pair_of_scissors):-
	person(X,_,_,hairdresser).
  %C. X Mungkin Memiliki Benda Tersebut Jika X Memiliki Benda Tersebut
  owns_probably(X,Object):-
	owns(X,Object).

/* * * * * * * * * * * * * * * * * * * * * * *
 * Suspect all those who own a weapon with   *
 * which Susan could have been killed.       *
 * * * * * * * * * * * * * * * * * * * * * * */

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%		4 KEMUNGKINAN TERSANGKA		%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% X = Nama Merupakan Tersangka Jika Susan Membunuh Dengan Senjata(Weapon),
% cara kerja dan X kemungkinan pemilik terpenuhi
  suspect(X):-
	killed_with(susan,Weapon),
	operates_identically(Object,Weapon) ,
	owns_probably(X,Object).

/* * * * * * * * * * * * * * * * * * * * * * * * * *
 * Suspect men who have had an affair with Susan.  *
 * * * * * * * * * * * * * * * * * * * * * * * * * */
% X = Nama Merupakan Tersangka Jika Cemburu Merupakan Motifnya,
% , X Berjenis Kelamin Laki - Laki dan X memiliki hubungan dengan susan
  suspect(X):-
	motive(jealousy),
	person(X,_,m,_),
	had_affair(susan,X).

/* * * * * * * * * * * * * * * * * * * * *
 * Suspect females who have had an       *
 * affair with someone that Susan knew.  *
 * * * * * * * * * * * * * * * * * * * * */
% X = Nama Merupakan Tersangka Jika Cemburu Merupakan Motifnya,
% X Berjenis Kelamin Wanita Dan Wanita Memiliki Hubungan Dengan susan.
  suspect(X):-
	motive(jealousy),
	person(X,_,f,_),
	had_affair(X,Man),
	had_affair(susan,Man).

/* * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Suspect pickpockets whose motive could be money.  *
 * * * * * * * * * * * * * * * * * * * * * * * * * * */
% X = Nama Merupakan Tersangka Jika Uang adalah Motifnya
% Dan X Memiliki Profesi Sebagai Pencopet
  suspect(X):-
	motive(money),
	person(X,_,_,pickpocket).
	

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%		KONDISI PEMBUNUH		%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% - Killer (Nama Pembunuh) Merupakan Pembunuh Jika
% - Pembunuh Seseorang Berusia, Berjenis Kelamin serta profesi apa saja,
% - Orang yang terbunuh Adalah Susan Dapat Dilihat dari fakta sebelumnya,
% - lalu pembunuh serta yang terbunuh adalah orang yang berbeda.
% - Pembunuh Merupakan Tersangka yang memiliki hubungan dengan orang yang terbunuh dapat dilihat dari 4 kemungkinan suspect (Tersangka) Ada 3 Kondisi Yang Memiliki keterkaitan Dengan Susan
% A. Fakta Pertama Memiliki Kondisi Jika Susan Terbunuh dengan Weapon(belum diketahui) Lalu kita periksa fakta killed_with bahwa susan terbunuh dengan senjata club, club ini memiliki hubungan
%    dengan wooden_leg, pada wooden_leg memiliki fakta bahwa dimiliki oleh bert sedangkan bar & football_boot yang berhubungan dengan club tidak memiliki fakta keterangan kepemilikan.
% B. Memiliki Kaitan Hanya saja tidak Ada menjelaskan Ke Arah Mana Nanti pelakunya yang benar.
% C. Disini Tidak Ada Menjelaskan Person yang berkelamin Wanita(f).
% - Pembunuh Berlumuran Darah Dan Yang Terbunuh Berlumuran Darah juga. dapat dilihat pada Fakta diatas smeared_in(berlumuran), dapat diketahui pada saat fakta suspect mengarah kepada bert
%   dan pembunuh yang sama lumurannya dengan dibunuh dengan darah adalah bert & susan.
  killer(Killer):-
	person(Killer,_,_,_),
	killed(Killed),
	Killed <> Killer, /* It is not a suicide */
	suspect(Killer),
	smeared_in(Killer,Goo),
	smeared_in(Killed,Goo).

goal
% Mencari sang Pembunuh
  killer(X).
