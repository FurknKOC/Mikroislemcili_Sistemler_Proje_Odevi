		ORG 00H
		SJMP GIRIS
		ORG 30H
GIRIS:  MOV P1,#0FFH ;Baslangic durumunda devrenin nasil olmasi gerektigini belirliyoruz.
		MOV P3,#0FFH
		MOV TMOD,#00H ;Timeri seciyoruz ve gerekli degerleri icine atiyoruz.
		MOV TH0,#00H
		MOV TL0,#0AH
		MOV TH1,#0E0H
		MOV TL1,#18H
BIRAK:	JNB P1.0,BIRAK ;Butona basilip basilmadigini kontrol ediyoruz.
		MOV P1,#0H
BAS:	JB P1.0,BAS
		MOV P3,#11111111B
		SETB TR1
		JNB TF1,BASLA
		MOV R5,#19
		SJMP BIRSANIYEDUR
BASLA:	JNB P1.0,BAS ;Butona basildiysa ledleri yakmaya basliyoruz.
		MOV P3,#11111110B
		MOV P2,#01110001B
		SETB TR0
KONTROL:JNB TF0,KONTROL ;10Ms arayla butun ledleri sirayla yakiyoruz.
		CLR TF0
		CLR TR0
		SJMP IKINCIKISIM
IKINCIKISIM:
		MOV P3,#11111101B
		MOV P2,#01110101B
		SETB TR0
KONTROL2:
		JNB TF0,KONTROL2
		CLR TF0
		CLR TR0
		SJMP UCUNCUKISIM
UCUNCUKISIM:
		MOV P3,#11111011B
		MOV P2,#00000110B
		SETB TR0
KONTROL3:
		JNB TF0,KONTROL3
		CLR TF0
		CLR TR0
		SJMP DORDUNCUKISIM
DORDUNCUKISIM:
		MOV P3,#11110111B
		MOV P2,#01011111B
		SETB TR0
KONTROL4:
		JNB TF0,KONTROL4
		CLR TF0
		CLR TR0
		DJNZ R5,BASLA ;Yakma isleminin 1 saniye olmasini saglamak icin 25 kere tekrar yaktiriyoruz.
		SJMP BIRSANIYEDUR
BIRSANIYEDUR: ;1 Saniye sondurme islemi icin 1 saniye ledleri sonduruyoruz.
		MOV R6,#4DH
		CLR TR1
		CLR TF1
LOOP:	ACALL DELAY
		DJNZ R6,LOOP
		CLR TR1
		CLR TF1
		MOV R5,#19 ;1 Saniye dolduktan sonra R5'i tekrar 25'e ayarlayip BASLA'ya dallaniyoruz.
		SJMP BASLA 
DELAY:	SETB TR1
		MOV P1,#0H
		MOV P3,#0FFH
HERE: 	JNB TF1,HERE
		CLR TR1 
		CLR TF1 
		RET
		RET		
		END
