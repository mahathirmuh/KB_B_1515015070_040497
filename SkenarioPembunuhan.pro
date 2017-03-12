/* 	Terdapat sebuah kasus yang mengerikan pada sebuah keluarga yang cukup besar,
	seorang pengusaha memiliki 2 orang istri dan setiap istri mempunyai anak tiri
	lalu terdapat juga perselingkuhan sehingga terjadilah pembunuhan dengan berbagai
	motif, untuk alur tragedinya dapat dilihat dari program prolog tersebut.
*/
DOMAINS
            nama,kelamin,pekerjaan,benda,alasan = symbol
            umur = integer
PREDICATES
            nondeterm orang(nama,umur,kelamin,pekerjaan)
            istri(nama, nama)
            anak(nama,nama)
            saudara(nama,nama)
            nondeterm dendam(nama,nama)
            nondeterm selingkuh(nama,nama)
            terbunuh_dengan(nama,benda) - nondeterm (o,o)
            terbunuh(nama) - nondeterm (o)
            nondeterm pembunuh(nama)
            motif(alasan)
            milik(nama,benda)
            nondeterm cara_kerja_dengan(benda,benda)
            nondeterm kemungkinan_milik(nama,benda)
            nondeterm dicurigai(nama)
           
CLAUSES
% Fakta - fakta sekitar mengenai terjadinya tragedi pembunuhan yang bermotif tersebut.
            orang(andi,37,l,pengusaha).orang(oliv,35,p,istri_pertama).
            orang(vita,30,p,istri_kedua).orang(jhalyl,22,l,anak_tiri).
            orang(novreza,40,l,tukang_kebun).orang(dina,45,p,pembantu).
            orang(chrisman,30,l,satpam).
           
            istri(oliv,andi).istri(vita,andi).istri(dina,novreza).
            
            saudara(chrisman,novreza).
            
            anak(mahathir,oliv).anak(kelvin,oliv).
            anak(andre,oliv).anak(jhalyl,vita).
           
            selingkuh(chrisman,vita).
            
            dendam(vita,oliv).
            dendam(jhalyl,andi).
           
            terbunuh_dengan(andi,ditusuk).terbunuh_dengan(susi,ditusuk).
            terbunuh_dengan(mahathir,ditembak).terbunuh_dengan(kelvin,ditembak).
            terbunuh_dengan(andre,ditembak).
            
            terbunuh(andi).terbunuh(susi).
            terbunuh(mahathir).terbunuh(kelvin).
            terbunuh(andre).
           
            motif(harta).motif(cemburu).motif(dendam).

            milik(vita,pisau).milik(jhalyl,pisau).milik(chrisman,pistol).
            
            %Dugaan cara kerja si pembunuh beraksi pada saat kejadian tersebut tersebut
            cara_kerja_dengan(pisau,ditusuk).
            cara_kerja_dengan(pistol,ditembak).
                       
            kemungkinan_milik(X,Benda) :-
                        milik(X,Benda).
                       
%dicurigai semua orang yang memiliki senjata yang kerjanya mirip dengan senjata penyebab Keluarga andi terbunuh
            dicurigai(X) :-
                        terbunuh_dengan(X,Senjata),
                        cara_kerja_dengan(Benda,Senjata),
                        kemungkinan_milik(X,Benda).
                       
%orang dicurgai yang cemburu dengan Andi
            dicurigai(X) :-
                        motif(cemburu),
                        orang(X,_,_,istri_kedua),
                        istri(oliv,X).
                       
%orang dicurigai yang dendam dengan keluarga Andi
            dicurigai(X) :-
                        motif(dendam),
                        orang(X,_,_,anak_tiri),
                        anak(kelvin,X),
                        anak(mahathir,X),
                        anak(andre,X).  

%orang dicurigai yang ingin harta andi
            dicurigai(X) :-
                        motif(harta),
                        orang(X,_,_,istri_kedua).
           
            dicurigai(X) :-
                        motif(harta),
                        orang(X,_,_,anak_tiri).
                       
            dicurigai(X) :-
                        motif(harta),
                        orang(X,_,_,satpam).
                       
            pembunuh(Pembunuh) :-
            dicurigai(Pembunuh).
            
goal
% lalu kita cari pembunuhnya
	pembunuh(X).