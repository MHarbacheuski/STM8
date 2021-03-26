   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.13 - 05 Feb 2019
   3                     ; Generator (Limited) V4.4.9 - 06 Feb 2019
   4                     ; Optimizer V4.4.9 - 06 Feb 2019
  19                     	switch	.data
  20  0000               _NT1:
  21  0000 64            	dc.b	100
  82                     ; 13 u8 b_f(u16 A)  // A - что ищем по таблице T1  длиной NT1 
  82                     ; 14 {
  84                     	switch	.text
  85  0000               f_b_f:
  87  0000 89            	pushw	x
  88  0001 5203          	subw	sp,#3
  89       00000003      OFST:	set	3
  92                     ; 16 left = (u8)0; right = (u8)(NT1-1);
  94  0003 0f02          	clr	(OFST-1,sp)
  98  0005 c60000        	ld	a,_NT1
  99  0008 4a            	dec	a
 100  0009 6b01          	ld	(OFST-2,sp),a
 102  000b               L33:
 103                     ; 19     if (left > right) return (0xff); // значение не найдено
 105  000b 7b02          	ld	a,(OFST-1,sp)
 106  000d 1101          	cp	a,(OFST-2,sp)
 107  000f 2304          	jrule	L73
 110  0011 a6ff          	ld	a,#255
 112  0013 203c          	jra	L21
 113  0015               L73:
 114                     ; 20     m = (u8)(left + (right - left) / 2);
 116  0015 7b01          	ld	a,(OFST-2,sp)
 117  0017 5f            	clrw	x
 118  0018 1002          	sub	a,(OFST-1,sp)
 119  001a 2401          	jrnc	L6
 120  001c 5a            	decw	x
 121  001d               L6:
 122  001d 02            	rlwa	x,a
 123  001e a602          	ld	a,#2
 124  0020 8d000000      	callf	d_sdivx
 126  0024 01            	rrwa	x,a
 127  0025 1b02          	add	a,(OFST-1,sp)
 128  0027 6b03          	ld	(OFST+0,sp),a
 130                     ; 21     if (T1[m] < A) left  =  (u8)(m + 1);
 132  0029 5f            	clrw	x
 133  002a 97            	ld	xl,a
 134  002b 58            	sllw	x
 135  002c de0002        	ldw	x,(_T1,x)
 136  002f 1304          	cpw	x,(OFST+1,sp)
 137  0031 2405          	jruge	L14
 140  0033 4c            	inc	a
 141  0034 6b02          	ld	(OFST-1,sp),a
 143  0036 7b03          	ld	a,(OFST+0,sp)
 144  0038               L14:
 145                     ; 22     if (T1[m] > A) right =  (u8)(m - 1);
 147  0038 5f            	clrw	x
 148  0039 97            	ld	xl,a
 149  003a 58            	sllw	x
 150  003b de0002        	ldw	x,(_T1,x)
 151  003e 1304          	cpw	x,(OFST+1,sp)
 152  0040 2305          	jrule	L34
 155  0042 4a            	dec	a
 156  0043 6b01          	ld	(OFST-2,sp),a
 158  0045 7b03          	ld	a,(OFST+0,sp)
 159  0047               L34:
 160                     ; 23     if (T1[m] == A) return m;
 162  0047 5f            	clrw	x
 163  0048 97            	ld	xl,a
 164  0049 58            	sllw	x
 165  004a de0002        	ldw	x,(_T1,x)
 166  004d 1304          	cpw	x,(OFST+1,sp)
 167  004f 26ba          	jrne	L33
 171  0051               L21:
 173  0051 5b05          	addw	sp,#5
 174  0053 87            	retf	
 229                     ; 28 u8 b_f1(u16 A)  // A - что ищем по таблице T1  длиной NT1 
 229                     ; 29 {
 230                     	switch	.text
 231  0054               f_b_f1:
 233  0054 89            	pushw	x
 234  0055 5203          	subw	sp,#3
 235       00000003      OFST:	set	3
 238                     ; 31 left = (u8)0; right = (u8)(NT1-1);
 240  0057 0f02          	clr	(OFST-1,sp)
 244  0059 c60000        	ld	a,_NT1
 245  005c               LC001:
 246  005c 4a            	dec	a
 247  005d 6b01          	ld	(OFST-2,sp),a
 249  005f 7b02          	ld	a,(OFST-1,sp)
 250  0061               L17:
 251                     ; 34     if (left > right) return (0xff); // значение не найдено
 253  0061 1101          	cp	a,(OFST-2,sp)
 254  0063 2304          	jrule	L57
 257  0065 a6ff          	ld	a,#255
 259  0067 201e          	jra	L22
 260  0069               L57:
 261                     ; 35     m = (u8)(left + (right - left) / 2);
 263  0069 7b01          	ld	a,(OFST-2,sp)
 264  006b 5f            	clrw	x
 265  006c 1002          	sub	a,(OFST-1,sp)
 266  006e 2401          	jrnc	L61
 267  0070 5a            	decw	x
 268  0071               L61:
 269  0071 02            	rlwa	x,a
 270  0072 a602          	ld	a,#2
 271  0074 8d000000      	callf	d_sdivx
 273  0078 01            	rrwa	x,a
 274  0079 1b02          	add	a,(OFST-1,sp)
 275  007b 6b03          	ld	(OFST+0,sp),a
 277                     ; 36     if (T1[m] == A) return m;
 279  007d 5f            	clrw	x
 280  007e 97            	ld	xl,a
 281  007f 58            	sllw	x
 282  0080 de0002        	ldw	x,(_T1,x)
 283  0083 1304          	cpw	x,(OFST+1,sp)
 284  0085 2603          	jrne	L77
 288  0087               L22:
 290  0087 5b05          	addw	sp,#5
 291  0089 87            	retf	
 292  008a               L77:
 293                     ; 37 		if(T1[m] < A) 
 295  008a 5f            	clrw	x
 296  008b 97            	ld	xl,a
 297  008c 58            	sllw	x
 298  008d de0002        	ldw	x,(_T1,x)
 299  0090 1304          	cpw	x,(OFST+1,sp)
 300  0092 24c8          	jruge	LC001
 301                     ; 39 		 left  =  (u8)(m + 1);
 303  0094 4c            	inc	a
 304  0095 6b02          	ld	(OFST-1,sp),a
 307  0097 20c8          	jra	L17
 308                     ; 43 		 right =  (u8)(m - 1);
 371                     ; 49 u8 b_f2(u16 A)  // A - что ищем по таблице T1  длиной NT1 
 371                     ; 50 {
 372                     	switch	.text
 373  0099               f_b_f2:
 375  0099 89            	pushw	x
 376  009a 5205          	subw	sp,#5
 377       00000005      OFST:	set	5
 380                     ; 53 left = (u8)0; right = (u8)(NT1-1);
 382  009c 0f04          	clr	(OFST-1,sp)
 386  009e c60000        	ld	a,_NT1
 387  00a1               LC002:
 388  00a1 4a            	dec	a
 389  00a2 6b03          	ld	(OFST-2,sp),a
 391  00a4 7b04          	ld	a,(OFST-1,sp)
 392  00a6               L131:
 393                     ; 56     if (left > right) return (0xff); // значение не найдено
 395  00a6 1103          	cp	a,(OFST-2,sp)
 396  00a8 2304          	jrule	L531
 399  00aa a6ff          	ld	a,#255
 401  00ac 201e          	jra	L23
 402  00ae               L531:
 403                     ; 57     m = (u8)(left + (right - left) / 2);
 405  00ae 7b03          	ld	a,(OFST-2,sp)
 406  00b0 5f            	clrw	x
 407  00b1 1004          	sub	a,(OFST-1,sp)
 408  00b3 2401          	jrnc	L62
 409  00b5 5a            	decw	x
 410  00b6               L62:
 411  00b6 02            	rlwa	x,a
 412  00b7 a602          	ld	a,#2
 413  00b9 8d000000      	callf	d_sdivx
 415  00bd 01            	rrwa	x,a
 416  00be 1b04          	add	a,(OFST-1,sp)
 417  00c0 6b05          	ld	(OFST+0,sp),a
 419                     ; 58 		r = T1[m];
 421  00c2 5f            	clrw	x
 422  00c3 97            	ld	xl,a
 423  00c4 58            	sllw	x
 424                     ; 59     if (T1[m] == A) return m;
 426  00c5 de0002        	ldw	x,(_T1,x)
 427  00c8 1306          	cpw	x,(OFST+1,sp)
 428  00ca 2603          	jrne	L731
 432  00cc               L23:
 434  00cc 5b07          	addw	sp,#7
 435  00ce 87            	retf	
 436  00cf               L731:
 437                     ; 60 		if(T1[m] < A) 
 439  00cf 5f            	clrw	x
 440  00d0 97            	ld	xl,a
 441  00d1 58            	sllw	x
 442  00d2 de0002        	ldw	x,(_T1,x)
 443  00d5 1306          	cpw	x,(OFST+1,sp)
 444  00d7 24c8          	jruge	LC002
 445                     ; 62 		 left  =  (u8)(m + 1);
 447  00d9 4c            	inc	a
 448  00da 6b04          	ld	(OFST-1,sp),a
 451  00dc 20c8          	jra	L131
 452                     ; 66 		 right =  (u8)(m - 1);
 491                     ; 74 u8 b_f3(u16 A)  // A - что ищем по таблице T1  длиной NT1 
 491                     ; 75 {
 492                     	switch	.text
 493  00de               f_b_f3:
 495       00000000      OFST:	set	0
 498                     ; 78 left = (u8)0; right = (u8)(NT1-1);
 500  00de 725f0003      	clr	_left
 501  00e2 89            	pushw	x
 504  00e3 c60000        	ld	a,_NT1
 505  00e6               LC003:
 506  00e6 4a            	dec	a
 507  00e7 c70002        	ld	_right,a
 508  00ea c60003        	ld	a,_left
 509  00ed               L161:
 510                     ; 81     if (left > right) return (0xff); // значение не найдено
 512  00ed c10002        	cp	a,_right
 513  00f0 2304          	jrule	L561
 516  00f2 a6ff          	ld	a,#255
 518  00f4 202b          	jra	L24
 519  00f6               L561:
 520                     ; 82     m = (u8)(left + (right - left) / 2);
 522  00f6 c60002        	ld	a,_right
 523  00f9 5f            	clrw	x
 524  00fa c00003        	sub	a,_left
 525  00fd 2401          	jrnc	L63
 526  00ff 5a            	decw	x
 527  0100               L63:
 528  0100 02            	rlwa	x,a
 529  0101 a602          	ld	a,#2
 530  0103 8d000000      	callf	d_sdivx
 532  0107 01            	rrwa	x,a
 533  0108 cb0003        	add	a,_left
 534  010b c70004        	ld	_m,a
 535                     ; 83 		r = T1[m];
 537  010e 5f            	clrw	x
 538  010f 97            	ld	xl,a
 539  0110 58            	sllw	x
 540  0111 de0002        	ldw	x,(_T1,x)
 541  0114 cf0000        	ldw	_r,x
 542                     ; 84     if (T1[m] == A) return m;
 544  0117 5f            	clrw	x
 545  0118 97            	ld	xl,a
 546  0119 58            	sllw	x
 547  011a de0002        	ldw	x,(_T1,x)
 548  011d 1301          	cpw	x,(OFST+1,sp)
 549  011f 2602          	jrne	L761
 553  0121               L24:
 555  0121 85            	popw	x
 556  0122 87            	retf	
 557  0123               L761:
 558                     ; 85 		if(T1[m] < A) 
 560  0123 5f            	clrw	x
 561  0124 97            	ld	xl,a
 562  0125 58            	sllw	x
 563  0126 de0002        	ldw	x,(_T1,x)
 564  0129 1301          	cpw	x,(OFST+1,sp)
 565  012b 24b9          	jruge	LC003
 566                     ; 87 		 left  =  (u8)(m + 1);
 568  012d 4c            	inc	a
 569  012e c70003        	ld	_left,a
 571  0131 20ba          	jra	L161
 572                     ; 91 		 right =  (u8)(m - 1);
 614                     ; 96 u8 P_f(u16 A)//последовательный поиск  
 614                     ; 97 {
 615                     	switch	.text
 616  0133               f_P_f:
 618  0133 89            	pushw	x
 619  0134 88            	push	a
 620       00000001      OFST:	set	1
 623                     ; 99 	for(m=0;m<NT1;m++)
 625  0135 0f01          	clr	(OFST+0,sp)
 628  0137 200c          	jra	L712
 629  0139               L312:
 630                     ; 101 	if (T1[m] == A) return m;
 632  0139 5f            	clrw	x
 633  013a 97            	ld	xl,a
 634  013b 58            	sllw	x
 635  013c de0002        	ldw	x,(_T1,x)
 636  013f 1302          	cpw	x,(OFST+1,sp)
 640  0141 270b          	jreq	L64
 641                     ; 99 	for(m=0;m<NT1;m++)
 643  0143 0c01          	inc	(OFST+0,sp)
 645  0145               L712:
 648  0145 7b01          	ld	a,(OFST+0,sp)
 649  0147 c10000        	cp	a,_NT1
 650  014a 25ed          	jrult	L312
 651                     ; 103 	return (0xff);
 653  014c a6ff          	ld	a,#255
 655  014e               L64:
 657  014e 5b03          	addw	sp,#3
 658  0150 87            	retf	
 661                     	switch	.data
 662  0001               _NNT:
 663  0001 03            	dc.b	3
 724                     ; 108 u8 bp_f4(u16 A)  // гибрид бинарного и последовательного  
 724                     ; 109 {
 725                     	switch	.text
 726  0151               f_bp_f4:
 728  0151 89            	pushw	x
 729  0152 5207          	subw	sp,#7
 730       00000007      OFST:	set	7
 733                     ; 112 left = (u8)0; right = (u8)(NT1-1);
 735  0154 0f06          	clr	(OFST-1,sp)
 739  0156 c60000        	ld	a,_NT1
 740  0159               LC004:
 741  0159 4a            	dec	a
 742  015a 6b05          	ld	(OFST-2,sp),a
 744  015c               L152:
 745                     ; 118    if (right - left < NNT)
 747  015c c60001        	ld	a,_NNT
 748  015f 5f            	clrw	x
 749  0160 97            	ld	xl,a
 750  0161 1f01          	ldw	(OFST-6,sp),x
 752  0163 5f            	clrw	x
 753  0164 7b05          	ld	a,(OFST-2,sp)
 754  0166 1006          	sub	a,(OFST-1,sp)
 755  0168 2401          	jrnc	L25
 756  016a 5a            	decw	x
 757  016b               L25:
 758  016b 02            	rlwa	x,a
 759  016c 1301          	cpw	x,(OFST-6,sp)
 760  016e 2e1d          	jrsge	L552
 761                     ; 120     for(m= left ;m<= right;m++)
 763  0170 7b06          	ld	a,(OFST-1,sp)
 764  0172 6b07          	ld	(OFST+0,sp),a
 767  0174 200e          	jra	L362
 768  0176               L752:
 769                     ; 122       if (T1[m]  == A) return m;
 771  0176 5f            	clrw	x
 772  0177 97            	ld	xl,a
 773  0178 58            	sllw	x
 774  0179 de0002        	ldw	x,(_T1,x)
 775  017c 1308          	cpw	x,(OFST+1,sp)
 778  017e 270a          	jreq	L06
 779                     ; 120     for(m= left ;m<= right;m++)
 781  0180 0c07          	inc	(OFST+0,sp)
 783  0182 7b07          	ld	a,(OFST+0,sp)
 784  0184               L362:
 787  0184 1105          	cp	a,(OFST-2,sp)
 788  0186 23ee          	jrule	L752
 789                     ; 124       return (0xff);
 791  0188 a6ff          	ld	a,#255
 793  018a               L06:
 795  018a 5b09          	addw	sp,#9
 796  018c 87            	retf	
 797  018d               L552:
 798                     ; 129     m = (u8)(left + (right - left) / 2);
 800  018d 7b05          	ld	a,(OFST-2,sp)
 801  018f 5f            	clrw	x
 802  0190 1006          	sub	a,(OFST-1,sp)
 803  0192 2401          	jrnc	L45
 804  0194 5a            	decw	x
 805  0195               L45:
 806  0195 02            	rlwa	x,a
 807  0196 a602          	ld	a,#2
 808  0198 8d000000      	callf	d_sdivx
 810  019c 01            	rrwa	x,a
 811  019d 1b06          	add	a,(OFST-1,sp)
 812  019f 6b07          	ld	(OFST+0,sp),a
 814                     ; 131     r=T1[m];  
 816  01a1 5f            	clrw	x
 817  01a2 97            	ld	xl,a
 818  01a3 58            	sllw	x
 819  01a4 de0002        	ldw	x,(_T1,x)
 820  01a7 1f03          	ldw	(OFST-4,sp),x
 822                     ; 132     if (r == A) return m;
 824  01a9 1308          	cpw	x,(OFST+1,sp)
 829  01ab 27dd          	jreq	L06
 830                     ; 133     if (r < A) left  =  (u8)(m + 1);
 832  01ad 24aa          	jruge	LC004
 835  01af 4c            	inc	a
 836  01b0 6b06          	ld	(OFST-1,sp),a
 839  01b2 20a8          	jra	L152
 840                     ; 134     else right =  (u8)(m - 1);
 844                     	switch	.data
 845  0002               _T1:
 846  0002 00f5          	dc.w	245
 847  0004 0614          	dc.w	1556
 848  0006 0bb2          	dc.w	2994
 849  0008 0dce          	dc.w	3534
 850  000a 0e7e          	dc.w	3710
 851  000c 0ed6          	dc.w	3798
 852  000e 1036          	dc.w	4150
 853  0010 131d          	dc.w	4893
 854  0012 1462          	dc.w	5218
 855  0014 149f          	dc.w	5279
 856  0016 14d1          	dc.w	5329
 857  0018 1527          	dc.w	5415
 858  001a 1558          	dc.w	5464
 859  001c 1f1b          	dc.w	7963
 860  001e 2018          	dc.w	8216
 861  0020 2078          	dc.w	8312
 862  0022 29ee          	dc.w	10734
 863  0024 2d93          	dc.w	11667
 864  0026 2e84          	dc.w	11908
 865  0028 35d3          	dc.w	13779
 866  002a 3779          	dc.w	14201
 867  002c 381e          	dc.w	14366
 868  002e 388d          	dc.w	14477
 869  0030 3938          	dc.w	14648
 870  0032 3a4a          	dc.w	14922
 871  0034 3b82          	dc.w	15234
 872  0036 4d46          	dc.w	19782
 873  0038 4f0a          	dc.w	20234
 874  003a 51a7          	dc.w	20903
 875  003c 5224          	dc.w	21028
 876  003e 5229          	dc.w	21033
 877  0040 53c0          	dc.w	21440
 878  0042 55e7          	dc.w	21991
 879  0044 58d7          	dc.w	22743
 880  0046 5a15          	dc.w	23061
 881  0048 5cb2          	dc.w	23730
 882  004a 636c          	dc.w	25452
 883  004c 637d          	dc.w	25469
 884  004e 6425          	dc.w	25637
 885  0050 6531          	dc.w	25905
 886  0052 65a2          	dc.w	26018
 887  0054 65eb          	dc.w	26091
 888  0056 66aa          	dc.w	26282
 889  0058 6ea9          	dc.w	28329
 890  005a 802e          	dc.w	-32722
 891  005c 8145          	dc.w	-32443
 892  005e 8555          	dc.w	-31403
 893  0060 8969          	dc.w	-30359
 894  0062 89ec          	dc.w	-30228
 895  0064 8a9a          	dc.w	-30054
 896  0066 8d38          	dc.w	-29384
 897  0068 8edd          	dc.w	-28963
 898  006a 9851          	dc.w	-26543
 899  006c 994d          	dc.w	-26291
 900  006e 9aff          	dc.w	-25857
 901  0070 9d77          	dc.w	-25225
 902  0072 9dce          	dc.w	-25138
 903  0074 a42d          	dc.w	-23507
 904  0076 a8ed          	dc.w	-22291
 905  0078 a901          	dc.w	-22271
 906  007a a930          	dc.w	-22224
 907  007c aa4e          	dc.w	-21938
 908  007e ac3d          	dc.w	-21443
 909  0080 b071          	dc.w	-20367
 910  0082 b1de          	dc.w	-20002
 911  0084 b1e5          	dc.w	-19995
 912  0086 b2ec          	dc.w	-19732
 913  0088 b588          	dc.w	-19064
 914  008a b6bb          	dc.w	-18757
 915  008c b996          	dc.w	-18026
 916  008e bdb4          	dc.w	-16972
 917  0090 be01          	dc.w	-16895
 918  0092 c3db          	dc.w	-15397
 919  0094 c51f          	dc.w	-15073
 920  0096 c617          	dc.w	-14825
 921  0098 c62e          	dc.w	-14802
 922  009a c641          	dc.w	-14783
 923  009c c798          	dc.w	-14440
 924  009e c865          	dc.w	-14235
 925  00a0 ca3e          	dc.w	-13762
 926  00a2 cebc          	dc.w	-12612
 927  00a4 cf13          	dc.w	-12525
 928  00a6 d139          	dc.w	-11975
 929  00a8 d202          	dc.w	-11774
 930  00aa d337          	dc.w	-11465
 931  00ac d3f5          	dc.w	-11275
 932  00ae ddab          	dc.w	-8789
 933  00b0 dfe0          	dc.w	-8224
 934  00b2 e110          	dc.w	-7920
 935  00b4 e2da          	dc.w	-7462
 936  00b6 e484          	dc.w	-7036
 937  00b8 e8a4          	dc.w	-5980
 938  00ba e9b3          	dc.w	-5709
 939  00bc ea63          	dc.w	-5533
 940  00be eaf8          	dc.w	-5384
 941  00c0 edb7          	dc.w	-4681
 942  00c2 ef2a          	dc.w	-4310
 943  00c4 ef86          	dc.w	-4218
 944  00c6 fad8          	dc.w	-1320
 945  00c8 fdb3          	dc.w	-589
 946  00ca               _T2:
 947  00ca 0385          	dc.w	901
 948  00cc 08e3          	dc.w	2275
 949  00ce 0cc0          	dc.w	3264
 950  00d0 0e26          	dc.w	3622
 951  00d2 0eaa          	dc.w	3754
 952  00d4 0f86          	dc.w	3974
 953  00d6 11aa          	dc.w	4522
 954  00d8 13c0          	dc.w	5056
 955  00da 1481          	dc.w	5249
 956  00dc 14b8          	dc.w	5304
 957  00de 14fc          	dc.w	5372
 958  00e0 1540          	dc.w	5440
 959  00e2 1a3a          	dc.w	6714
 960  00e4 1f9a          	dc.w	8090
 961  00e6 2048          	dc.w	8264
 962  00e8 2533          	dc.w	9523
 963  00ea 2bc1          	dc.w	11201
 964  00ec 2e0c          	dc.w	11788
 965  00ee 322c          	dc.w	12844
 966  00f0 36a6          	dc.w	13990
 967  00f2 37cc          	dc.w	14284
 968  00f4 3856          	dc.w	14422
 969  00f6 38e3          	dc.w	14563
 970  00f8 39c1          	dc.w	14785
 971  00fa 3ae6          	dc.w	15078
 972  00fc 4464          	dc.w	17508
 973  00fe 4e28          	dc.w	20008
 974  0100 5059          	dc.w	20569
 975  0102 51e6          	dc.w	20966
 976  0104 5227          	dc.w	21031
 977  0106 52f5          	dc.w	21237
 978  0108 54d4          	dc.w	21716
 979  010a 575f          	dc.w	22367
 980  010c 5976          	dc.w	22902
 981  010e 5b64          	dc.w	23396
 982  0110 600f          	dc.w	24591
 983  0112 6375          	dc.w	25461
 984  0114 63d1          	dc.w	25553
 985  0116 64ab          	dc.w	25771
 986  0118 656a          	dc.w	25962
 987  011a 65c7          	dc.w	26055
 988  011c 664b          	dc.w	26187
 989  011e 6aaa          	dc.w	27306
 990  0120 776c          	dc.w	30572
 991  0122 80ba          	dc.w	-32582
 992  0124 834d          	dc.w	-31923
 993  0126 875f          	dc.w	-30881
 994  0128 89ab          	dc.w	-30293
 995  012a 8a43          	dc.w	-30141
 996  012c 8be9          	dc.w	-29719
 997  012e 8e0b          	dc.w	-29173
 998  0130 9397          	dc.w	-27753
 999  0132 98cf          	dc.w	-26417
1000  0134 9a26          	dc.w	-26074
1001  0136 9c3b          	dc.w	-25541
1002  0138 9da3          	dc.w	-25181
1003  013a a0fe          	dc.w	-24322
1004  013c a68d          	dc.w	-22899
1005  013e a8f7          	dc.w	-22281
1006  0140 a919          	dc.w	-22247
1007  0142 a9bf          	dc.w	-22081
1008  0144 ab46          	dc.w	-21690
1009  0146 ae57          	dc.w	-20905
1010  0148 b128          	dc.w	-20184
1011  014a b1e2          	dc.w	-19998
1012  014c b269          	dc.w	-19863
1013  014e b43a          	dc.w	-19398
1014  0150 b622          	dc.w	-18910
1015  0152 b829          	dc.w	-18391
1016  0154 bba5          	dc.w	-17499
1017  0156 bddb          	dc.w	-16933
1018  0158 c0ee          	dc.w	-16146
1019  015a c47d          	dc.w	-15235
1020  015c c59b          	dc.w	-14949
1021  015e c623          	dc.w	-14813
1022  0160 c638          	dc.w	-14792
1023  0162 c6ed          	dc.w	-14611
1024  0164 c7ff          	dc.w	-14337
1025  0166 c952          	dc.w	-13998
1026  0168 cc7d          	dc.w	-13187
1027  016a cee8          	dc.w	-12568
1028  016c d026          	dc.w	-12250
1029  016e d19e          	dc.w	-11874
1030  0170 d29d          	dc.w	-11619
1031  0172 d396          	dc.w	-11370
1032  0174 d8d0          	dc.w	-10032
1033  0176 dec6          	dc.w	-8506
1034  0178 e078          	dc.w	-8072
1035  017a e1f5          	dc.w	-7691
1036  017c e3af          	dc.w	-7249
1037  017e e694          	dc.w	-6508
1038  0180 e92c          	dc.w	-5844
1039  0182 ea0b          	dc.w	-5621
1040  0184 eaae          	dc.w	-5458
1041  0186 ec58          	dc.w	-5032
1042  0188 ee71          	dc.w	-4495
1043  018a ef58          	dc.w	-4264
1044  018c f52f          	dc.w	-2769
1045  018e fc46          	dc.w	-954
1046  0190 fdcc          	dc.w	-564
1121                     	xdef	f_bp_f4
1122                     	xdef	_NNT
1123                     	xdef	f_P_f
1124                     	xdef	f_b_f3
1125                     	switch	.bss
1126  0000               _r:
1127  0000 0000          	ds.b	2
1128                     	xdef	_r
1129  0002               _right:
1130  0002 00            	ds.b	1
1131                     	xdef	_right
1132  0003               _left:
1133  0003 00            	ds.b	1
1134                     	xdef	_left
1135  0004               _m:
1136  0004 00            	ds.b	1
1137                     	xdef	_m
1138                     	xdef	f_b_f2
1139                     	xdef	f_b_f1
1140                     	xdef	f_b_f
1141                     	xdef	_T2
1142                     	xdef	_NT1
1143                     	xdef	_T1
1144                     	xref.b	c_x
1164                     	xref	d_sdivx
1165                     	end
