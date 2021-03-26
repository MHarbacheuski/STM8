   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
  46                     ; 70 void IM_UR_init(void)
  46                     ; 71 {  // прием
  48                     	switch	.text
  49  0000               f_IM_UR_init:
  53                     ; 72 	IM_UR_rcv.Nm=0; // 
  55  0000 725f00cc      	clr	_IM_UR_rcv+100
  56                     ; 73 	IM_UR_rcv.F=0;
  58  0004 725f00cd      	clr	_IM_UR_rcv+101
  59                     ; 74   IM_UR_rcv.Fspc = 0;
  61  0008 725f00ce      	clr	_IM_UR_rcv+102
  62                     ; 75 	IM_UR_rcv.stat = 1;
  64  000c 350100cf      	mov	_IM_UR_rcv+103,#1
  65                     ; 76 	IM_UR_rcv.err1=0;
  67  0010 5f            	clrw	x
  68  0011 cf00d0        	ldw	_IM_UR_rcv+104,x
  69                     ; 77   IM_UR_rcv. Fr_res=1; // =1 - был принят "03"
  71  0014 350100d3      	mov	_IM_UR_rcv+107,#1
  72                     ; 79 	IM_UR_tr.Nm=0;
  74  0018 725f0064      	clr	_IM_UR_tr+100
  75                     ; 80 	IM_UR_tr.F=0;
  77  001c 725f0066      	clr	_IM_UR_tr+102
  78                     ; 81 	IM_UR_tr.Fr03=0;     // =1 - надо передать абоненту "03"
  80  0020 725f0067      	clr	_IM_UR_tr+103
  81                     ; 83 }
  84  0024 87            	retf
 141                     ; 85 u8 IM_UR_put(u8 m[],u8 len) // оформление кадра на передачу 
 141                     ; 86                             // len<=50
 141                     ; 87                             // =0 - занято, кадр не принят 
 141                     ; 88 														// =1 - OK
 141                     ; 89  {
 142                     	switch	.text
 143  0025               f_IM_UR_put:
 145  0025 89            	pushw	x
 146  0026 89            	pushw	x
 147       00000002      OFST:	set	2
 150                     ; 93 	if(IM_UR_tr.F==1) return 0;  // занято, идет передача пред кадра
 152  0027 c60066        	ld	a,_IM_UR_tr+102
 153  002a a101          	cp	a,#1
 154  002c 2603          	jrne	L54
 157  002e 4f            	clr	a
 159  002f 2007          	jra	L01
 160  0031               L54:
 161                     ; 95 	if(len>50)        return 0;
 163  0031 7b08          	ld	a,(OFST+6,sp)
 164  0033 a133          	cp	a,#51
 165  0035 2504          	jrult	L74
 168  0037 4f            	clr	a
 170  0038               L01:
 172  0038 5b04          	addw	sp,#4
 173  003a 87            	retf
 174  003b               L74:
 175                     ; 96 	IM_UR_tr.m[0]=0;               // начало кадра
 177  003b 725f0000      	clr	_IM_UR_tr
 178                     ; 97 	i=1;
 180  003f a601          	ld	a,#1
 181  0041 6b02          	ld	(OFST+0,sp),a
 183                     ; 98 	for(i1=0;i1<len;i1++)
 185  0043 0f01          	clr	(OFST-1,sp)
 188  0045 2045          	jra	L55
 189  0047               L15:
 190                     ; 100 		if(m[i1] < 4)      // надо перекодировать 
 192  0047 7b01          	ld	a,(OFST-1,sp)
 193  0049 5f            	clrw	x
 194  004a 97            	ld	xl,a
 195  004b 72fb03        	addw	x,(OFST+1,sp)
 196  004e f6            	ld	a,(x)
 197  004f a104          	cp	a,#4
 198  0051 2423          	jruge	L16
 199                     ; 102 		IM_UR_tr.m[i]=(u8)0x02;i++;	IM_UR_tr.m[i]=(u8)(m[i1]+0x80);i++;
 201  0053 7b02          	ld	a,(OFST+0,sp)
 202  0055 5f            	clrw	x
 203  0056 97            	ld	xl,a
 204  0057 a602          	ld	a,#2
 205  0059 d70000        	ld	(_IM_UR_tr,x),a
 208  005c 0c02          	inc	(OFST+0,sp)
 212  005e 7b02          	ld	a,(OFST+0,sp)
 213  0060 5f            	clrw	x
 214  0061 97            	ld	xl,a
 215  0062 7b01          	ld	a,(OFST-1,sp)
 216  0064 905f          	clrw	y
 217  0066 9097          	ld	yl,a
 218  0068 72f903        	addw	y,(OFST+1,sp)
 219  006b 90f6          	ld	a,(y)
 220  006d ab80          	add	a,#128
 221  006f d70000        	ld	(_IM_UR_tr,x),a
 224  0072 0c02          	inc	(OFST+0,sp)
 227  0074 2014          	jra	L36
 228  0076               L16:
 229                     ; 105 	 {IM_UR_tr.m[i]=(u8)(m[i1]);i++;}
 231  0076 7b02          	ld	a,(OFST+0,sp)
 232  0078 5f            	clrw	x
 233  0079 97            	ld	xl,a
 234  007a 7b01          	ld	a,(OFST-1,sp)
 235  007c 905f          	clrw	y
 236  007e 9097          	ld	yl,a
 237  0080 72f903        	addw	y,(OFST+1,sp)
 238  0083 90f6          	ld	a,(y)
 239  0085 d70000        	ld	(_IM_UR_tr,x),a
 242  0088 0c02          	inc	(OFST+0,sp)
 244  008a               L36:
 245                     ; 98 	for(i1=0;i1<len;i1++)
 247  008a 0c01          	inc	(OFST-1,sp)
 249  008c               L55:
 252  008c 7b01          	ld	a,(OFST-1,sp)
 253  008e 1108          	cp	a,(OFST+6,sp)
 254  0090 25b5          	jrult	L15
 255                     ; 108 	 	IM_UR_tr.m[i]=1;      // конец кадра
 257  0092 7b02          	ld	a,(OFST+0,sp)
 258  0094 5f            	clrw	x
 259  0095 97            	ld	xl,a
 260  0096 a601          	ld	a,#1
 261  0098 d70000        	ld	(_IM_UR_tr,x),a
 262                     ; 109 		IM_UR_tr.Nm=(u8)(i+1);  // длина на передачу
 264  009b 7b02          	ld	a,(OFST+0,sp)
 265  009d 4c            	inc	a
 266  009e c70064        	ld	_IM_UR_tr+100,a
 267                     ; 117   return   1;        // кадр принят
 269  00a1 a601          	ld	a,#1
 271  00a3 2093          	jra	L01
 329                     ; 130 u8 IM_UR_get(u8 m[]) //перезапись принятого кадра наверх
 329                     ; 131                      // возвр 0 - нет кадра, не0 - длина
 329                     ; 132 
 329                     ; 133 {
 330                     	switch	.text
 331  00a5               f_IM_UR_get:
 333  00a5 89            	pushw	x
 334  00a6 5203          	subw	sp,#3
 335       00000003      OFST:	set	3
 338                     ; 134 	u8 f=0,  
 340  00a8 0f01          	clr	(OFST-2,sp)
 342                     ; 138 	if(IM_UR_rcv.F==0) return 0;
 344  00aa 725d00cd      	tnz	_IM_UR_rcv+101
 345  00ae 2603          	jrne	L111
 348  00b0 4f            	clr	a
 350  00b1 205e          	jra	L41
 351  00b3               L111:
 352                     ; 140 	for(i=i1=0;i<IM_UR_rcv.Nm;i++)
 354  00b3 0f02          	clr	(OFST-1,sp)
 356  00b5 0f03          	clr	(OFST+0,sp)
 359  00b7 2043          	jra	L711
 360  00b9               L311:
 361                     ; 142 		if(IM_UR_rcv.m[i]==0x02) f=1;// перекодировка признак
 363  00b9 7b03          	ld	a,(OFST+0,sp)
 364  00bb 5f            	clrw	x
 365  00bc 97            	ld	xl,a
 366  00bd d60068        	ld	a,(_IM_UR_rcv,x)
 367  00c0 a102          	cp	a,#2
 368  00c2 2606          	jrne	L321
 371  00c4 a601          	ld	a,#1
 372  00c6 6b01          	ld	(OFST-2,sp),a
 375  00c8 2030          	jra	L521
 376  00ca               L321:
 377                     ; 145 			if(f==0) m[i1] = IM_UR_rcv.m[i];
 379  00ca 0d01          	tnz	(OFST-2,sp)
 380  00cc 2614          	jrne	L721
 383  00ce 7b02          	ld	a,(OFST-1,sp)
 384  00d0 5f            	clrw	x
 385  00d1 97            	ld	xl,a
 386  00d2 72fb04        	addw	x,(OFST+1,sp)
 387  00d5 7b03          	ld	a,(OFST+0,sp)
 388  00d7 905f          	clrw	y
 389  00d9 9097          	ld	yl,a
 390  00db 90d60068      	ld	a,(_IM_UR_rcv,y)
 391  00df f7            	ld	(x),a
 393  00e0 2016          	jra	L131
 394  00e2               L721:
 395                     ; 146 			else     m[i1] = (u8)(IM_UR_rcv.m[i]& 0x7f),// перекодировка
 395                     ; 147 			         f=0; // сброс признака 
 397  00e2 7b02          	ld	a,(OFST-1,sp)
 398  00e4 5f            	clrw	x
 399  00e5 97            	ld	xl,a
 400  00e6 72fb04        	addw	x,(OFST+1,sp)
 401  00e9 7b03          	ld	a,(OFST+0,sp)
 402  00eb 905f          	clrw	y
 403  00ed 9097          	ld	yl,a
 404  00ef 90d60068      	ld	a,(_IM_UR_rcv,y)
 405  00f3 a47f          	and	a,#127
 406  00f5 f7            	ld	(x),a
 407  00f6 0f01          	clr	(OFST-2,sp)
 409  00f8               L131:
 410                     ; 148 			i1++;   //
 412  00f8 0c02          	inc	(OFST-1,sp)
 414  00fa               L521:
 415                     ; 140 	for(i=i1=0;i<IM_UR_rcv.Nm;i++)
 417  00fa 0c03          	inc	(OFST+0,sp)
 419  00fc               L711:
 422  00fc 7b03          	ld	a,(OFST+0,sp)
 423  00fe c100cc        	cp	a,_IM_UR_rcv+100
 424  0101 25b6          	jrult	L311
 425                     ; 151 	IM_UR_rcv.F=0;      // буфер пуст
 427  0103 725f00cd      	clr	_IM_UR_rcv+101
 428                     ; 152 	IM_UR_rcv.stat = 1; // прерываниям - ждем приема начала кадра
 430  0107 350100cf      	mov	_IM_UR_rcv+103,#1
 431                     ; 163 	IM_UR_tr.Fr03=1;      // пока так
 433  010b 35010067      	mov	_IM_UR_tr+103,#1
 434                     ; 165 	return i1;
 436  010f 7b02          	ld	a,(OFST-1,sp)
 438  0111               L41:
 440  0111 5b05          	addw	sp,#5
 441  0113 87            	retf
 466                     ; 169 void tst_interr(void)   // то что в прерываниях
 466                     ; 170 {
 467                     	switch	.text
 468  0114               f_tst_interr:
 472                     ; 175 	IM_UR_rcv.b=bbbbb;   /// для тестирования !!!!!!!!!11 
 474  0114 5500d400d2    	mov	_IM_UR_rcv+106,_bbbbb
 475                     ; 177 if(IM_UR_rcv.b==3){IM_UR_rcv.Fr_res=1;return;}
 477  0119 c600d2        	ld	a,_IM_UR_rcv+106
 478  011c a103          	cp	a,#3
 479  011e 2605          	jrne	L341
 482  0120 350100d3      	mov	_IM_UR_rcv+107,#1
 486  0124 87            	retf
 487  0125               L341:
 488                     ; 178 if(IM_UR_rcv.stat==0)                 return;
 490  0125 725d00cf      	tnz	_IM_UR_rcv+103
 491  0129 2601          	jrne	L541
 495  012b 87            	retf
 496  012c               L541:
 497                     ; 179 if(IM_UR_rcv.stat==1)
 499  012c c600cf        	ld	a,_IM_UR_rcv+103
 500  012f a101          	cp	a,#1
 501  0131 260f          	jrne	L741
 502                     ; 181   if(IM_UR_rcv.b==0) // есть начало кадра
 504  0133 725d00d2      	tnz	_IM_UR_rcv+106
 505  0137 2608          	jrne	L151
 506                     ; 183 		IM_UR_rcv.Nm=0;	
 508  0139 725f00cc      	clr	_IM_UR_rcv+100
 509                     ; 184 		IM_UR_rcv.stat=2;
 511  013d 350200cf      	mov	_IM_UR_rcv+103,#2
 512  0141               L151:
 513                     ; 186 	return;
 516  0141 87            	retf
 517  0142               L741:
 518                     ; 190 	 if(IM_UR_rcv.b==1)  // это конец кадра
 520  0142 c600d2        	ld	a,_IM_UR_rcv+106
 521  0145 a101          	cp	a,#1
 522  0147 260a          	jrne	L351
 523                     ; 192 		 IM_UR_rcv.F=1;     // кадр завершен
 525  0149 350100cd      	mov	_IM_UR_rcv+101,#1
 526                     ; 193      IM_UR_rcv.stat=0;	// не будем принимать ,
 528  014d 725f00cf      	clr	_IM_UR_rcv+103
 530  0151 2023          	jra	L551
 531  0153               L351:
 532                     ; 197 	  { IM_UR_rcv.m[IM_UR_rcv.Nm]=IM_UR_rcv.b; // неперекодиров байт	
 534  0153 c600cc        	ld	a,_IM_UR_rcv+100
 535  0156 5f            	clrw	x
 536  0157 97            	ld	xl,a
 537  0158 c600d2        	ld	a,_IM_UR_rcv+106
 538  015b d70068        	ld	(_IM_UR_rcv,x),a
 539                     ; 198 		  IM_UR_rcv.Nm++;
 541  015e 725c00cc      	inc	_IM_UR_rcv+100
 542                     ; 199 			if(IM_UR_rcv.Nm>=IM_UART_BUF_RES_LEN)
 544  0162 c600cc        	ld	a,_IM_UR_rcv+100
 545  0165 a164          	cp	a,#100
 546  0167 250d          	jrult	L551
 547                     ; 201 			 IM_UR_rcv.stat=1; // защита от переполнения буфера
 549  0169 350100cf      	mov	_IM_UR_rcv+103,#1
 550                     ; 202        IM_UR_rcv.err1++;			
 552  016d ce00d0        	ldw	x,_IM_UR_rcv+104
 553  0170 1c0001        	addw	x,#1
 554  0173 cf00d0        	ldw	_IM_UR_rcv+104,x
 555  0176               L551:
 556                     ; 205 	 return;
 559  0176 87            	retf
 712                     	xdef	f_tst_interr
 713                     	xdef	f_IM_UR_get
 714                     	xdef	f_IM_UR_put
 715                     	xdef	f_IM_UR_init
 716                     	switch	.bss
 717  0000               _IM_UR_tr:
 718  0000 000000000000  	ds.b	104
 719                     	xdef	_IM_UR_tr
 720  0068               _IM_UR_rcv:
 721  0068 000000000000  	ds.b	108
 722                     	xdef	_IM_UR_rcv
 723  00d4               _bbbbb:
 724  00d4 00            	ds.b	1
 725                     	xdef	_bbbbb
 745                     	end
