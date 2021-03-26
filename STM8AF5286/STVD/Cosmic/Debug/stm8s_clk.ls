   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  19                     .const:	section	.text
  20  0000               _HSIDivFactor:
  21  0000 01            	dc.b	1
  22  0001 02            	dc.b	2
  23  0002 04            	dc.b	4
  24  0003 08            	dc.b	8
  25  0004               _CLKPrescTable:
  26  0004 01            	dc.b	1
  27  0005 02            	dc.b	2
  28  0006 04            	dc.b	4
  29  0007 08            	dc.b	8
  30  0008 0a            	dc.b	10
  31  0009 10            	dc.b	16
  32  000a 14            	dc.b	20
  33  000b 28            	dc.b	40
  62                     ; 66 void CLK_DeInit(void)
  62                     ; 67 {
  64                     	switch	.text
  65  0000               f_CLK_DeInit:
  69                     ; 69     CLK->ICKR = CLK_ICKR_RESET_VALUE;
  71  0000 350150c0      	mov	20672,#1
  72                     ; 70     CLK->ECKR = CLK_ECKR_RESET_VALUE;
  74  0004 725f50c1      	clr	20673
  75                     ; 71     CLK->SWR  = CLK_SWR_RESET_VALUE;
  77  0008 35e150c4      	mov	20676,#225
  78                     ; 72     CLK->SWCR = CLK_SWCR_RESET_VALUE;
  80  000c 725f50c5      	clr	20677
  81                     ; 73     CLK->CKDIVR = CLK_CKDIVR_RESET_VALUE;
  83  0010 351850c6      	mov	20678,#24
  84                     ; 74     CLK->PCKENR1 = CLK_PCKENR1_RESET_VALUE;
  86  0014 35ff50c7      	mov	20679,#255
  87                     ; 75     CLK->PCKENR2 = CLK_PCKENR2_RESET_VALUE;
  89  0018 35ff50ca      	mov	20682,#255
  90                     ; 76     CLK->CSSR = CLK_CSSR_RESET_VALUE;
  92  001c 725f50c8      	clr	20680
  93                     ; 77     CLK->CCOR = CLK_CCOR_RESET_VALUE;
  95  0020 725f50c9      	clr	20681
  97  0024               L52:
  98                     ; 78     while ((CLK->CCOR & CLK_CCOR_CCOEN)!= 0)
 100  0024 720050c9fb    	btjt	20681,#0,L52
 101                     ; 80     CLK->CCOR = CLK_CCOR_RESET_VALUE;
 103  0029 725f50c9      	clr	20681
 104                     ; 81     CLK->HSITRIMR = CLK_HSITRIMR_RESET_VALUE;
 106  002d 725f50cc      	clr	20684
 107                     ; 82     CLK->SWIMCCR = CLK_SWIMCCR_RESET_VALUE;
 109  0031 725f50cd      	clr	20685
 110                     ; 84 }
 113  0035 87            	retf	
 170                     ; 95 void CLK_FastHaltWakeUpCmd(FunctionalState NewState)
 170                     ; 96 {
 171                     	switch	.text
 172  0036               f_CLK_FastHaltWakeUpCmd:
 174  0036 88            	push	a
 175       00000000      OFST:	set	0
 178                     ; 99     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 180  0037 4d            	tnz	a
 181  0038 2712          	jreq	L41
 182  003a 4a            	dec	a
 183  003b 270f          	jreq	L41
 184  003d ae0063        	ldw	x,#99
 185  0040 89            	pushw	x
 186  0041 5f            	clrw	x
 187  0042 89            	pushw	x
 188  0043 ae000c        	ldw	x,#L75
 189  0046 8d000000      	callf	f_assert_failed
 191  004a 5b04          	addw	sp,#4
 192  004c               L41:
 193                     ; 101     if (NewState != DISABLE)
 195  004c 7b01          	ld	a,(OFST+1,sp)
 196  004e 2706          	jreq	L16
 197                     ; 104         CLK->ICKR |= CLK_ICKR_FHWU;
 199  0050 721450c0      	bset	20672,#2
 201  0054 2004          	jra	L36
 202  0056               L16:
 203                     ; 109         CLK->ICKR &= (uint8_t)(~CLK_ICKR_FHWU);
 205  0056 721550c0      	bres	20672,#2
 206  005a               L36:
 207                     ; 112 }
 210  005a 84            	pop	a
 211  005b 87            	retf	
 247                     ; 119 void CLK_HSECmd(FunctionalState NewState)
 247                     ; 120 {
 248                     	switch	.text
 249  005c               f_CLK_HSECmd:
 251  005c 88            	push	a
 252       00000000      OFST:	set	0
 255                     ; 123     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 257  005d 4d            	tnz	a
 258  005e 2712          	jreq	L62
 259  0060 4a            	dec	a
 260  0061 270f          	jreq	L62
 261  0063 ae007b        	ldw	x,#123
 262  0066 89            	pushw	x
 263  0067 5f            	clrw	x
 264  0068 89            	pushw	x
 265  0069 ae000c        	ldw	x,#L75
 266  006c 8d000000      	callf	f_assert_failed
 268  0070 5b04          	addw	sp,#4
 269  0072               L62:
 270                     ; 125     if (NewState != DISABLE)
 272  0072 7b01          	ld	a,(OFST+1,sp)
 273  0074 2706          	jreq	L301
 274                     ; 128         CLK->ECKR |= CLK_ECKR_HSEEN;
 276  0076 721050c1      	bset	20673,#0
 278  007a 2004          	jra	L501
 279  007c               L301:
 280                     ; 133         CLK->ECKR &= (uint8_t)(~CLK_ECKR_HSEEN);
 282  007c 721150c1      	bres	20673,#0
 283  0080               L501:
 284                     ; 136 }
 287  0080 84            	pop	a
 288  0081 87            	retf	
 324                     ; 143 void CLK_HSICmd(FunctionalState NewState)
 324                     ; 144 {
 325                     	switch	.text
 326  0082               f_CLK_HSICmd:
 328  0082 88            	push	a
 329       00000000      OFST:	set	0
 332                     ; 147     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 334  0083 4d            	tnz	a
 335  0084 2712          	jreq	L04
 336  0086 4a            	dec	a
 337  0087 270f          	jreq	L04
 338  0089 ae0093        	ldw	x,#147
 339  008c 89            	pushw	x
 340  008d 5f            	clrw	x
 341  008e 89            	pushw	x
 342  008f ae000c        	ldw	x,#L75
 343  0092 8d000000      	callf	f_assert_failed
 345  0096 5b04          	addw	sp,#4
 346  0098               L04:
 347                     ; 149     if (NewState != DISABLE)
 349  0098 7b01          	ld	a,(OFST+1,sp)
 350  009a 2706          	jreq	L521
 351                     ; 152         CLK->ICKR |= CLK_ICKR_HSIEN;
 353  009c 721050c0      	bset	20672,#0
 355  00a0 2004          	jra	L721
 356  00a2               L521:
 357                     ; 157         CLK->ICKR &= (uint8_t)(~CLK_ICKR_HSIEN);
 359  00a2 721150c0      	bres	20672,#0
 360  00a6               L721:
 361                     ; 160 }
 364  00a6 84            	pop	a
 365  00a7 87            	retf	
 401                     ; 167 void CLK_LSICmd(FunctionalState NewState)
 401                     ; 168 {
 402                     	switch	.text
 403  00a8               f_CLK_LSICmd:
 405  00a8 88            	push	a
 406       00000000      OFST:	set	0
 409                     ; 171     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 411  00a9 4d            	tnz	a
 412  00aa 2712          	jreq	L25
 413  00ac 4a            	dec	a
 414  00ad 270f          	jreq	L25
 415  00af ae00ab        	ldw	x,#171
 416  00b2 89            	pushw	x
 417  00b3 5f            	clrw	x
 418  00b4 89            	pushw	x
 419  00b5 ae000c        	ldw	x,#L75
 420  00b8 8d000000      	callf	f_assert_failed
 422  00bc 5b04          	addw	sp,#4
 423  00be               L25:
 424                     ; 173     if (NewState != DISABLE)
 426  00be 7b01          	ld	a,(OFST+1,sp)
 427  00c0 2706          	jreq	L741
 428                     ; 176         CLK->ICKR |= CLK_ICKR_LSIEN;
 430  00c2 721650c0      	bset	20672,#3
 432  00c6 2004          	jra	L151
 433  00c8               L741:
 434                     ; 181         CLK->ICKR &= (uint8_t)(~CLK_ICKR_LSIEN);
 436  00c8 721750c0      	bres	20672,#3
 437  00cc               L151:
 438                     ; 184 }
 441  00cc 84            	pop	a
 442  00cd 87            	retf	
 478                     ; 192 void CLK_CCOCmd(FunctionalState NewState)
 478                     ; 193 {
 479                     	switch	.text
 480  00ce               f_CLK_CCOCmd:
 482  00ce 88            	push	a
 483       00000000      OFST:	set	0
 486                     ; 196     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 488  00cf 4d            	tnz	a
 489  00d0 2712          	jreq	L46
 490  00d2 4a            	dec	a
 491  00d3 270f          	jreq	L46
 492  00d5 ae00c4        	ldw	x,#196
 493  00d8 89            	pushw	x
 494  00d9 5f            	clrw	x
 495  00da 89            	pushw	x
 496  00db ae000c        	ldw	x,#L75
 497  00de 8d000000      	callf	f_assert_failed
 499  00e2 5b04          	addw	sp,#4
 500  00e4               L46:
 501                     ; 198     if (NewState != DISABLE)
 503  00e4 7b01          	ld	a,(OFST+1,sp)
 504  00e6 2706          	jreq	L171
 505                     ; 201         CLK->CCOR |= CLK_CCOR_CCOEN;
 507  00e8 721050c9      	bset	20681,#0
 509  00ec 2004          	jra	L371
 510  00ee               L171:
 511                     ; 206         CLK->CCOR &= (uint8_t)(~CLK_CCOR_CCOEN);
 513  00ee 721150c9      	bres	20681,#0
 514  00f2               L371:
 515                     ; 209 }
 518  00f2 84            	pop	a
 519  00f3 87            	retf	
 555                     ; 218 void CLK_ClockSwitchCmd(FunctionalState NewState)
 555                     ; 219 {
 556                     	switch	.text
 557  00f4               f_CLK_ClockSwitchCmd:
 559  00f4 88            	push	a
 560       00000000      OFST:	set	0
 563                     ; 222     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 565  00f5 4d            	tnz	a
 566  00f6 2712          	jreq	L67
 567  00f8 4a            	dec	a
 568  00f9 270f          	jreq	L67
 569  00fb ae00de        	ldw	x,#222
 570  00fe 89            	pushw	x
 571  00ff 5f            	clrw	x
 572  0100 89            	pushw	x
 573  0101 ae000c        	ldw	x,#L75
 574  0104 8d000000      	callf	f_assert_failed
 576  0108 5b04          	addw	sp,#4
 577  010a               L67:
 578                     ; 224     if (NewState != DISABLE )
 580  010a 7b01          	ld	a,(OFST+1,sp)
 581  010c 2706          	jreq	L312
 582                     ; 227         CLK->SWCR |= CLK_SWCR_SWEN;
 584  010e 721250c5      	bset	20677,#1
 586  0112 2004          	jra	L512
 587  0114               L312:
 588                     ; 232         CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWEN);
 590  0114 721350c5      	bres	20677,#1
 591  0118               L512:
 592                     ; 235 }
 595  0118 84            	pop	a
 596  0119 87            	retf	
 633                     ; 245 void CLK_SlowActiveHaltWakeUpCmd(FunctionalState NewState)
 633                     ; 246 {
 634                     	switch	.text
 635  011a               f_CLK_SlowActiveHaltWakeUpCmd:
 637  011a 88            	push	a
 638       00000000      OFST:	set	0
 641                     ; 249     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 643  011b 4d            	tnz	a
 644  011c 2712          	jreq	L011
 645  011e 4a            	dec	a
 646  011f 270f          	jreq	L011
 647  0121 ae00f9        	ldw	x,#249
 648  0124 89            	pushw	x
 649  0125 5f            	clrw	x
 650  0126 89            	pushw	x
 651  0127 ae000c        	ldw	x,#L75
 652  012a 8d000000      	callf	f_assert_failed
 654  012e 5b04          	addw	sp,#4
 655  0130               L011:
 656                     ; 251     if (NewState != DISABLE)
 658  0130 7b01          	ld	a,(OFST+1,sp)
 659  0132 2706          	jreq	L532
 660                     ; 254         CLK->ICKR |= CLK_ICKR_SWUAH;
 662  0134 721a50c0      	bset	20672,#5
 664  0138 2004          	jra	L732
 665  013a               L532:
 666                     ; 259         CLK->ICKR &= (uint8_t)(~CLK_ICKR_SWUAH);
 668  013a 721b50c0      	bres	20672,#5
 669  013e               L732:
 670                     ; 262 }
 673  013e 84            	pop	a
 674  013f 87            	retf	
 834                     ; 272 void CLK_PeripheralClockConfig(CLK_Peripheral_TypeDef CLK_Peripheral, FunctionalState NewState)
 834                     ; 273 {
 835                     	switch	.text
 836  0140               f_CLK_PeripheralClockConfig:
 838  0140 89            	pushw	x
 839       00000000      OFST:	set	0
 842                     ; 276     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 844  0141 9f            	ld	a,xl
 845  0142 4d            	tnz	a
 846  0143 2713          	jreq	L221
 847  0145 9f            	ld	a,xl
 848  0146 4a            	dec	a
 849  0147 270f          	jreq	L221
 850  0149 ae0114        	ldw	x,#276
 851  014c 89            	pushw	x
 852  014d 5f            	clrw	x
 853  014e 89            	pushw	x
 854  014f ae000c        	ldw	x,#L75
 855  0152 8d000000      	callf	f_assert_failed
 857  0156 5b04          	addw	sp,#4
 858  0158               L221:
 859                     ; 277     assert_param(IS_CLK_PERIPHERAL_OK(CLK_Peripheral));
 861  0158 7b01          	ld	a,(OFST+1,sp)
 862  015a 273d          	jreq	L231
 863  015c a101          	cp	a,#1
 864  015e 2739          	jreq	L231
 865  0160 a103          	cp	a,#3
 866  0162 2735          	jreq	L231
 867  0164 a102          	cp	a,#2
 868  0166 2731          	jreq	L231
 869  0168 a104          	cp	a,#4
 870  016a 272d          	jreq	L231
 871  016c a105          	cp	a,#5
 872  016e 2729          	jreq	L231
 873  0170 a104          	cp	a,#4
 874  0172 2725          	jreq	L231
 875  0174 a106          	cp	a,#6
 876  0176 2721          	jreq	L231
 877  0178 a107          	cp	a,#7
 878  017a 271d          	jreq	L231
 879  017c a117          	cp	a,#23
 880  017e 2719          	jreq	L231
 881  0180 a113          	cp	a,#19
 882  0182 2715          	jreq	L231
 883  0184 a112          	cp	a,#18
 884  0186 2711          	jreq	L231
 885  0188 ae0115        	ldw	x,#277
 886  018b 89            	pushw	x
 887  018c 5f            	clrw	x
 888  018d 89            	pushw	x
 889  018e ae000c        	ldw	x,#L75
 890  0191 8d000000      	callf	f_assert_failed
 892  0195 5b04          	addw	sp,#4
 893  0197 7b01          	ld	a,(OFST+1,sp)
 894  0199               L231:
 895                     ; 279     if (((uint8_t)CLK_Peripheral & (uint8_t)0x10) == 0x00)
 897  0199 a510          	bcp	a,#16
 898  019b 262c          	jrne	L323
 899                     ; 281         if (NewState != DISABLE)
 901  019d 0d02          	tnz	(OFST+2,sp)
 902  019f 2712          	jreq	L523
 903                     ; 284             CLK->PCKENR1 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
 905  01a1 a40f          	and	a,#15
 906  01a3 5f            	clrw	x
 907  01a4 97            	ld	xl,a
 908  01a5 a601          	ld	a,#1
 909  01a7 5d            	tnzw	x
 910  01a8 2704          	jreq	L631
 911  01aa               L041:
 912  01aa 48            	sll	a
 913  01ab 5a            	decw	x
 914  01ac 26fc          	jrne	L041
 915  01ae               L631:
 916  01ae ca50c7        	or	a,20679
 918  01b1 2011          	jp	LC002
 919  01b3               L523:
 920                     ; 289             CLK->PCKENR1 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
 922  01b3 a40f          	and	a,#15
 923  01b5 5f            	clrw	x
 924  01b6 97            	ld	xl,a
 925  01b7 a601          	ld	a,#1
 926  01b9 5d            	tnzw	x
 927  01ba 2704          	jreq	L241
 928  01bc               L441:
 929  01bc 48            	sll	a
 930  01bd 5a            	decw	x
 931  01be 26fc          	jrne	L441
 932  01c0               L241:
 933  01c0 43            	cpl	a
 934  01c1 c450c7        	and	a,20679
 935  01c4               LC002:
 936  01c4 c750c7        	ld	20679,a
 937  01c7 202a          	jra	L133
 938  01c9               L323:
 939                     ; 294         if (NewState != DISABLE)
 941  01c9 0d02          	tnz	(OFST+2,sp)
 942  01cb 2712          	jreq	L333
 943                     ; 297             CLK->PCKENR2 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
 945  01cd a40f          	and	a,#15
 946  01cf 5f            	clrw	x
 947  01d0 97            	ld	xl,a
 948  01d1 a601          	ld	a,#1
 949  01d3 5d            	tnzw	x
 950  01d4 2704          	jreq	L641
 951  01d6               L051:
 952  01d6 48            	sll	a
 953  01d7 5a            	decw	x
 954  01d8 26fc          	jrne	L051
 955  01da               L641:
 956  01da ca50ca        	or	a,20682
 958  01dd 2011          	jp	LC001
 959  01df               L333:
 960                     ; 302             CLK->PCKENR2 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
 962  01df a40f          	and	a,#15
 963  01e1 5f            	clrw	x
 964  01e2 97            	ld	xl,a
 965  01e3 a601          	ld	a,#1
 966  01e5 5d            	tnzw	x
 967  01e6 2704          	jreq	L251
 968  01e8               L451:
 969  01e8 48            	sll	a
 970  01e9 5a            	decw	x
 971  01ea 26fc          	jrne	L451
 972  01ec               L251:
 973  01ec 43            	cpl	a
 974  01ed c450ca        	and	a,20682
 975  01f0               LC001:
 976  01f0 c750ca        	ld	20682,a
 977  01f3               L133:
 978                     ; 306 }
 981  01f3 85            	popw	x
 982  01f4 87            	retf	
1169                     ; 319 ErrorStatus CLK_ClockSwitchConfig(CLK_SwitchMode_TypeDef CLK_SwitchMode, CLK_Source_TypeDef CLK_NewClock, FunctionalState ITState, CLK_CurrentClockState_TypeDef CLK_CurrentClockState)
1169                     ; 320 {
1170                     	switch	.text
1171  01f5               f_CLK_ClockSwitchConfig:
1173  01f5 89            	pushw	x
1174  01f6 5204          	subw	sp,#4
1175       00000004      OFST:	set	4
1178                     ; 323     uint16_t DownCounter = CLK_TIMEOUT;
1180  01f8 ae0491        	ldw	x,#1169
1181  01fb 1f03          	ldw	(OFST-1,sp),x
1183                     ; 324     ErrorStatus Swif = ERROR;
1185                     ; 327     assert_param(IS_CLK_SOURCE_OK(CLK_NewClock));
1187  01fd 7b06          	ld	a,(OFST+2,sp)
1188  01ff a1e1          	cp	a,#225
1189  0201 2717          	jreq	L461
1190  0203 a1d2          	cp	a,#210
1191  0205 2713          	jreq	L461
1192  0207 a1b4          	cp	a,#180
1193  0209 270f          	jreq	L461
1194  020b ae0147        	ldw	x,#327
1195  020e 89            	pushw	x
1196  020f 5f            	clrw	x
1197  0210 89            	pushw	x
1198  0211 ae000c        	ldw	x,#L75
1199  0214 8d000000      	callf	f_assert_failed
1201  0218 5b04          	addw	sp,#4
1202  021a               L461:
1203                     ; 328     assert_param(IS_CLK_SWITCHMODE_OK(CLK_SwitchMode));
1205  021a 7b05          	ld	a,(OFST+1,sp)
1206  021c 2712          	jreq	L471
1207  021e 4a            	dec	a
1208  021f 270f          	jreq	L471
1209  0221 ae0148        	ldw	x,#328
1210  0224 89            	pushw	x
1211  0225 5f            	clrw	x
1212  0226 89            	pushw	x
1213  0227 ae000c        	ldw	x,#L75
1214  022a 8d000000      	callf	f_assert_failed
1216  022e 5b04          	addw	sp,#4
1217  0230               L471:
1218                     ; 329     assert_param(IS_FUNCTIONALSTATE_OK(ITState));
1220  0230 7b0a          	ld	a,(OFST+6,sp)
1221  0232 2712          	jreq	L402
1222  0234 4a            	dec	a
1223  0235 270f          	jreq	L402
1224  0237 ae0149        	ldw	x,#329
1225  023a 89            	pushw	x
1226  023b 5f            	clrw	x
1227  023c 89            	pushw	x
1228  023d ae000c        	ldw	x,#L75
1229  0240 8d000000      	callf	f_assert_failed
1231  0244 5b04          	addw	sp,#4
1232  0246               L402:
1233                     ; 330     assert_param(IS_CLK_CURRENTCLOCKSTATE_OK(CLK_CurrentClockState));
1235  0246 7b0b          	ld	a,(OFST+7,sp)
1236  0248 2712          	jreq	L412
1237  024a 4a            	dec	a
1238  024b 270f          	jreq	L412
1239  024d ae014a        	ldw	x,#330
1240  0250 89            	pushw	x
1241  0251 5f            	clrw	x
1242  0252 89            	pushw	x
1243  0253 ae000c        	ldw	x,#L75
1244  0256 8d000000      	callf	f_assert_failed
1246  025a 5b04          	addw	sp,#4
1247  025c               L412:
1248                     ; 333     clock_master = (CLK_Source_TypeDef)CLK->CMSR;
1250  025c c650c3        	ld	a,20675
1251  025f 6b01          	ld	(OFST-3,sp),a
1253                     ; 336     if (CLK_SwitchMode == CLK_SWITCHMODE_AUTO)
1255  0261 7b05          	ld	a,(OFST+1,sp)
1256  0263 4a            	dec	a
1257  0264 262d          	jrne	L544
1258                     ; 340         CLK->SWCR |= CLK_SWCR_SWEN;
1260  0266 721250c5      	bset	20677,#1
1261                     ; 343         if (ITState != DISABLE)
1263  026a 7b0a          	ld	a,(OFST+6,sp)
1264  026c 2706          	jreq	L744
1265                     ; 345             CLK->SWCR |= CLK_SWCR_SWIEN;
1267  026e 721450c5      	bset	20677,#2
1269  0272 2004          	jra	L154
1270  0274               L744:
1271                     ; 349             CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIEN);
1273  0274 721550c5      	bres	20677,#2
1274  0278               L154:
1275                     ; 353         CLK->SWR = (uint8_t)CLK_NewClock;
1277  0278 7b06          	ld	a,(OFST+2,sp)
1278  027a c750c4        	ld	20676,a
1280  027d 2003          	jra	L754
1281  027f               L354:
1282                     ; 357             DownCounter--;
1284  027f 5a            	decw	x
1285  0280 1f03          	ldw	(OFST-1,sp),x
1287  0282               L754:
1288                     ; 355         while ((((CLK->SWCR & CLK_SWCR_SWBSY) != 0 )&& (DownCounter != 0)))
1290  0282 720150c504    	btjf	20677,#0,L364
1292  0287 1e03          	ldw	x,(OFST-1,sp)
1293  0289 26f4          	jrne	L354
1294  028b               L364:
1295                     ; 360         if (DownCounter != 0)
1297  028b 1e03          	ldw	x,(OFST-1,sp)
1298                     ; 362             Swif = SUCCESS;
1300  028d 2617          	jrne	LC003
1301                     ; 366             Swif = ERROR;
1303  028f 0f02          	clr	(OFST-2,sp)
1305  0291 2017          	jra	L174
1306  0293               L544:
1307                     ; 374         if (ITState != DISABLE)
1309  0293 7b0a          	ld	a,(OFST+6,sp)
1310  0295 2706          	jreq	L374
1311                     ; 376             CLK->SWCR |= CLK_SWCR_SWIEN;
1313  0297 721450c5      	bset	20677,#2
1315  029b 2004          	jra	L574
1316  029d               L374:
1317                     ; 380             CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIEN);
1319  029d 721550c5      	bres	20677,#2
1320  02a1               L574:
1321                     ; 384         CLK->SWR = (uint8_t)CLK_NewClock;
1323  02a1 7b06          	ld	a,(OFST+2,sp)
1324  02a3 c750c4        	ld	20676,a
1325                     ; 388         Swif = SUCCESS;
1327  02a6               LC003:
1329  02a6 a601          	ld	a,#1
1330  02a8 6b02          	ld	(OFST-2,sp),a
1332  02aa               L174:
1333                     ; 393     if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_HSI))
1335  02aa 7b0b          	ld	a,(OFST+7,sp)
1336  02ac 260c          	jrne	L774
1338  02ae 7b01          	ld	a,(OFST-3,sp)
1339  02b0 a1e1          	cp	a,#225
1340  02b2 2606          	jrne	L774
1341                     ; 395         CLK->ICKR &= (uint8_t)(~CLK_ICKR_HSIEN);
1343  02b4 721150c0      	bres	20672,#0
1345  02b8 201e          	jra	L105
1346  02ba               L774:
1347                     ; 397     else if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_LSI))
1349  02ba 7b0b          	ld	a,(OFST+7,sp)
1350  02bc 260c          	jrne	L305
1352  02be 7b01          	ld	a,(OFST-3,sp)
1353  02c0 a1d2          	cp	a,#210
1354  02c2 2606          	jrne	L305
1355                     ; 399         CLK->ICKR &= (uint8_t)(~CLK_ICKR_LSIEN);
1357  02c4 721750c0      	bres	20672,#3
1359  02c8 200e          	jra	L105
1360  02ca               L305:
1361                     ; 401     else if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_HSE))
1363  02ca 7b0b          	ld	a,(OFST+7,sp)
1364  02cc 260a          	jrne	L105
1366  02ce 7b01          	ld	a,(OFST-3,sp)
1367  02d0 a1b4          	cp	a,#180
1368  02d2 2604          	jrne	L105
1369                     ; 403         CLK->ECKR &= (uint8_t)(~CLK_ECKR_HSEEN);
1371  02d4 721150c1      	bres	20673,#0
1372  02d8               L105:
1373                     ; 406     return(Swif);
1375  02d8 7b02          	ld	a,(OFST-2,sp)
1378  02da 5b06          	addw	sp,#6
1379  02dc 87            	retf	
1518                     ; 416 void CLK_HSIPrescalerConfig(CLK_Prescaler_TypeDef HSIPrescaler)
1518                     ; 417 {
1519                     	switch	.text
1520  02dd               f_CLK_HSIPrescalerConfig:
1522  02dd 88            	push	a
1523       00000000      OFST:	set	0
1526                     ; 420     assert_param(IS_CLK_HSIPRESCALER_OK(HSIPrescaler));
1528  02de 4d            	tnz	a
1529  02df 271b          	jreq	L622
1530  02e1 a108          	cp	a,#8
1531  02e3 2717          	jreq	L622
1532  02e5 a110          	cp	a,#16
1533  02e7 2713          	jreq	L622
1534  02e9 a118          	cp	a,#24
1535  02eb 270f          	jreq	L622
1536  02ed ae01a4        	ldw	x,#420
1537  02f0 89            	pushw	x
1538  02f1 5f            	clrw	x
1539  02f2 89            	pushw	x
1540  02f3 ae000c        	ldw	x,#L75
1541  02f6 8d000000      	callf	f_assert_failed
1543  02fa 5b04          	addw	sp,#4
1544  02fc               L622:
1545                     ; 423     CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_HSIDIV);
1547  02fc c650c6        	ld	a,20678
1548  02ff a4e7          	and	a,#231
1549  0301 c750c6        	ld	20678,a
1550                     ; 426     CLK->CKDIVR |= (uint8_t)HSIPrescaler;
1552  0304 c650c6        	ld	a,20678
1553  0307 1a01          	or	a,(OFST+1,sp)
1554  0309 c750c6        	ld	20678,a
1555                     ; 428 }
1558  030c 84            	pop	a
1559  030d 87            	retf	
1695                     ; 439 void CLK_CCOConfig(CLK_Output_TypeDef CLK_CCO)
1695                     ; 440 {
1696                     	switch	.text
1697  030e               f_CLK_CCOConfig:
1699  030e 88            	push	a
1700       00000000      OFST:	set	0
1703                     ; 443     assert_param(IS_CLK_OUTPUT_OK(CLK_CCO));
1705  030f 4d            	tnz	a
1706  0310 273f          	jreq	L042
1707  0312 a104          	cp	a,#4
1708  0314 273b          	jreq	L042
1709  0316 a102          	cp	a,#2
1710  0318 2737          	jreq	L042
1711  031a a108          	cp	a,#8
1712  031c 2733          	jreq	L042
1713  031e a10a          	cp	a,#10
1714  0320 272f          	jreq	L042
1715  0322 a10c          	cp	a,#12
1716  0324 272b          	jreq	L042
1717  0326 a10e          	cp	a,#14
1718  0328 2727          	jreq	L042
1719  032a a110          	cp	a,#16
1720  032c 2723          	jreq	L042
1721  032e a112          	cp	a,#18
1722  0330 271f          	jreq	L042
1723  0332 a114          	cp	a,#20
1724  0334 271b          	jreq	L042
1725  0336 a116          	cp	a,#22
1726  0338 2717          	jreq	L042
1727  033a a118          	cp	a,#24
1728  033c 2713          	jreq	L042
1729  033e a11a          	cp	a,#26
1730  0340 270f          	jreq	L042
1731  0342 ae01bb        	ldw	x,#443
1732  0345 89            	pushw	x
1733  0346 5f            	clrw	x
1734  0347 89            	pushw	x
1735  0348 ae000c        	ldw	x,#L75
1736  034b 8d000000      	callf	f_assert_failed
1738  034f 5b04          	addw	sp,#4
1739  0351               L042:
1740                     ; 446     CLK->CCOR &= (uint8_t)(~CLK_CCOR_CCOSEL);
1742  0351 c650c9        	ld	a,20681
1743  0354 a4e1          	and	a,#225
1744  0356 c750c9        	ld	20681,a
1745                     ; 449     CLK->CCOR |= (uint8_t)CLK_CCO;
1747  0359 c650c9        	ld	a,20681
1748  035c 1a01          	or	a,(OFST+1,sp)
1749  035e c750c9        	ld	20681,a
1750                     ; 452     CLK->CCOR |= CLK_CCOR_CCOEN;
1752  0361 721050c9      	bset	20681,#0
1753                     ; 454 }
1756  0365 84            	pop	a
1757  0366 87            	retf	
1823                     ; 464 void CLK_ITConfig(CLK_IT_TypeDef CLK_IT, FunctionalState NewState)
1823                     ; 465 {
1824                     	switch	.text
1825  0367               f_CLK_ITConfig:
1827  0367 89            	pushw	x
1828       00000000      OFST:	set	0
1831                     ; 468     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1833  0368 9f            	ld	a,xl
1834  0369 4d            	tnz	a
1835  036a 2713          	jreq	L252
1836  036c 9f            	ld	a,xl
1837  036d 4a            	dec	a
1838  036e 270f          	jreq	L252
1839  0370 ae01d4        	ldw	x,#468
1840  0373 89            	pushw	x
1841  0374 5f            	clrw	x
1842  0375 89            	pushw	x
1843  0376 ae000c        	ldw	x,#L75
1844  0379 8d000000      	callf	f_assert_failed
1846  037d 5b04          	addw	sp,#4
1847  037f               L252:
1848                     ; 469     assert_param(IS_CLK_IT_OK(CLK_IT));
1850  037f 7b01          	ld	a,(OFST+1,sp)
1851  0381 a10c          	cp	a,#12
1852  0383 2713          	jreq	L262
1853  0385 a11c          	cp	a,#28
1854  0387 270f          	jreq	L262
1855  0389 ae01d5        	ldw	x,#469
1856  038c 89            	pushw	x
1857  038d 5f            	clrw	x
1858  038e 89            	pushw	x
1859  038f ae000c        	ldw	x,#L75
1860  0392 8d000000      	callf	f_assert_failed
1862  0396 5b04          	addw	sp,#4
1863  0398               L262:
1864                     ; 471     if (NewState != DISABLE)
1866  0398 7b02          	ld	a,(OFST+2,sp)
1867  039a 2716          	jreq	L507
1868                     ; 473         switch (CLK_IT)
1870  039c 7b01          	ld	a,(OFST+1,sp)
1872                     ; 481         default:
1872                     ; 482             break;
1873  039e a00c          	sub	a,#12
1874  03a0 270a          	jreq	L146
1875  03a2 a010          	sub	a,#16
1876  03a4 2620          	jrne	L317
1877                     ; 475         case CLK_IT_SWIF: /* Enable the clock switch interrupt */
1877                     ; 476             CLK->SWCR |= CLK_SWCR_SWIEN;
1879  03a6 721450c5      	bset	20677,#2
1880                     ; 477             break;
1882  03aa 201a          	jra	L317
1883  03ac               L146:
1884                     ; 478         case CLK_IT_CSSD: /* Enable the clock security system detection interrupt */
1884                     ; 479             CLK->CSSR |= CLK_CSSR_CSSDIE;
1886  03ac 721450c8      	bset	20680,#2
1887                     ; 480             break;
1889  03b0 2014          	jra	L317
1890                     ; 481         default:
1890                     ; 482             break;
1893  03b2               L507:
1894                     ; 487         switch (CLK_IT)
1896  03b2 7b01          	ld	a,(OFST+1,sp)
1898                     ; 495         default:
1898                     ; 496             break;
1899  03b4 a00c          	sub	a,#12
1900  03b6 270a          	jreq	L746
1901  03b8 a010          	sub	a,#16
1902  03ba 260a          	jrne	L317
1903                     ; 489         case CLK_IT_SWIF: /* Disable the clock switch interrupt */
1903                     ; 490             CLK->SWCR  &= (uint8_t)(~CLK_SWCR_SWIEN);
1905  03bc 721550c5      	bres	20677,#2
1906                     ; 491             break;
1908  03c0 2004          	jra	L317
1909  03c2               L746:
1910                     ; 492         case CLK_IT_CSSD: /* Disable the clock security system detection interrupt */
1910                     ; 493             CLK->CSSR &= (uint8_t)(~CLK_CSSR_CSSDIE);
1912  03c2 721550c8      	bres	20680,#2
1913                     ; 494             break;
1914  03c6               L317:
1915                     ; 500 }
1918  03c6 85            	popw	x
1919  03c7 87            	retf	
1920                     ; 495         default:
1920                     ; 496             break;
1957                     ; 507 void CLK_SYSCLKConfig(CLK_Prescaler_TypeDef CLK_Prescaler)
1957                     ; 508 {
1958                     	switch	.text
1959  03c8               f_CLK_SYSCLKConfig:
1961  03c8 88            	push	a
1962       00000000      OFST:	set	0
1965                     ; 511     assert_param(IS_CLK_PRESCALER_OK(CLK_Prescaler));
1967  03c9 4d            	tnz	a
1968  03ca 273b          	jreq	L472
1969  03cc a108          	cp	a,#8
1970  03ce 2737          	jreq	L472
1971  03d0 a110          	cp	a,#16
1972  03d2 2733          	jreq	L472
1973  03d4 a118          	cp	a,#24
1974  03d6 272f          	jreq	L472
1975  03d8 a180          	cp	a,#128
1976  03da 272b          	jreq	L472
1977  03dc a181          	cp	a,#129
1978  03de 2727          	jreq	L472
1979  03e0 a182          	cp	a,#130
1980  03e2 2723          	jreq	L472
1981  03e4 a183          	cp	a,#131
1982  03e6 271f          	jreq	L472
1983  03e8 a184          	cp	a,#132
1984  03ea 271b          	jreq	L472
1985  03ec a185          	cp	a,#133
1986  03ee 2717          	jreq	L472
1987  03f0 a186          	cp	a,#134
1988  03f2 2713          	jreq	L472
1989  03f4 a187          	cp	a,#135
1990  03f6 270f          	jreq	L472
1991  03f8 ae01ff        	ldw	x,#511
1992  03fb 89            	pushw	x
1993  03fc 5f            	clrw	x
1994  03fd 89            	pushw	x
1995  03fe ae000c        	ldw	x,#L75
1996  0401 8d000000      	callf	f_assert_failed
1998  0405 5b04          	addw	sp,#4
1999  0407               L472:
2000                     ; 513     if (((uint8_t)CLK_Prescaler & (uint8_t)0x80) == 0x00) /* Bit7 = 0 means HSI divider */
2002  0407 7b01          	ld	a,(OFST+1,sp)
2003  0409 2b0e          	jrmi	L737
2004                     ; 515         CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_HSIDIV);
2006  040b c650c6        	ld	a,20678
2007  040e a4e7          	and	a,#231
2008  0410 c750c6        	ld	20678,a
2009                     ; 516         CLK->CKDIVR |= (uint8_t)((uint8_t)CLK_Prescaler & (uint8_t)CLK_CKDIVR_HSIDIV);
2011  0413 7b01          	ld	a,(OFST+1,sp)
2012  0415 a418          	and	a,#24
2014  0417 200c          	jra	L147
2015  0419               L737:
2016                     ; 520         CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_CPUDIV);
2018  0419 c650c6        	ld	a,20678
2019  041c a4f8          	and	a,#248
2020  041e c750c6        	ld	20678,a
2021                     ; 521         CLK->CKDIVR |= (uint8_t)((uint8_t)CLK_Prescaler & (uint8_t)CLK_CKDIVR_CPUDIV);
2023  0421 7b01          	ld	a,(OFST+1,sp)
2024  0423 a407          	and	a,#7
2025  0425               L147:
2026  0425 ca50c6        	or	a,20678
2027  0428 c750c6        	ld	20678,a
2028                     ; 524 }
2031  042b 84            	pop	a
2032  042c 87            	retf	
2089                     ; 531 void CLK_SWIMConfig(CLK_SWIMDivider_TypeDef CLK_SWIMDivider)
2089                     ; 532 {
2090                     	switch	.text
2091  042d               f_CLK_SWIMConfig:
2093  042d 88            	push	a
2094       00000000      OFST:	set	0
2097                     ; 535     assert_param(IS_CLK_SWIMDIVIDER_OK(CLK_SWIMDivider));
2099  042e 4d            	tnz	a
2100  042f 2712          	jreq	L603
2101  0431 4a            	dec	a
2102  0432 270f          	jreq	L603
2103  0434 ae0217        	ldw	x,#535
2104  0437 89            	pushw	x
2105  0438 5f            	clrw	x
2106  0439 89            	pushw	x
2107  043a ae000c        	ldw	x,#L75
2108  043d 8d000000      	callf	f_assert_failed
2110  0441 5b04          	addw	sp,#4
2111  0443               L603:
2112                     ; 537     if (CLK_SWIMDivider != CLK_SWIMDIVIDER_2)
2114  0443 7b01          	ld	a,(OFST+1,sp)
2115  0445 2706          	jreq	L177
2116                     ; 540         CLK->SWIMCCR |= CLK_SWIMCCR_SWIMDIV;
2118  0447 721050cd      	bset	20685,#0
2120  044b 2004          	jra	L377
2121  044d               L177:
2122                     ; 545         CLK->SWIMCCR &= (uint8_t)(~CLK_SWIMCCR_SWIMDIV);
2124  044d 721150cd      	bres	20685,#0
2125  0451               L377:
2126                     ; 548 }
2129  0451 84            	pop	a
2130  0452 87            	retf	
2154                     ; 557 void CLK_ClockSecuritySystemEnable(void)
2154                     ; 558 {
2155                     	switch	.text
2156  0453               f_CLK_ClockSecuritySystemEnable:
2160                     ; 560     CLK->CSSR |= CLK_CSSR_CSSEN;
2162  0453 721050c8      	bset	20680,#0
2163                     ; 561 }
2166  0457 87            	retf	
2191                     ; 569 CLK_Source_TypeDef CLK_GetSYSCLKSource(void)
2191                     ; 570 {
2192                     	switch	.text
2193  0458               f_CLK_GetSYSCLKSource:
2197                     ; 571     return((CLK_Source_TypeDef)CLK->CMSR);
2199  0458 c650c3        	ld	a,20675
2202  045b 87            	retf	
2259                     ; 579 uint32_t CLK_GetClockFreq(void)
2259                     ; 580 {
2260                     	switch	.text
2261  045c               f_CLK_GetClockFreq:
2263  045c 5209          	subw	sp,#9
2264       00000009      OFST:	set	9
2267                     ; 582     uint32_t clockfrequency = 0;
2269                     ; 583     CLK_Source_TypeDef clocksource = CLK_SOURCE_HSI;
2271                     ; 584     uint8_t tmp = 0, presc = 0;
2275                     ; 587     clocksource = (CLK_Source_TypeDef)CLK->CMSR;
2277  045e c650c3        	ld	a,20675
2278  0461 6b09          	ld	(OFST+0,sp),a
2280                     ; 589     if (clocksource == CLK_SOURCE_HSI)
2282  0463 a1e1          	cp	a,#225
2283  0465 2637          	jrne	L1401
2284                     ; 591         tmp = (uint8_t)(CLK->CKDIVR & CLK_CKDIVR_HSIDIV);
2286  0467 c650c6        	ld	a,20678
2287  046a a418          	and	a,#24
2288  046c 44            	srl	a
2289  046d 44            	srl	a
2290  046e 44            	srl	a
2292                     ; 592         tmp = (uint8_t)(tmp >> 3);
2295                     ; 593         presc = HSIDivFactor[tmp];
2297  046f 5f            	clrw	x
2298  0470 97            	ld	xl,a
2299  0471 d60000        	ld	a,(_HSIDivFactor,x)
2300  0474 6b09          	ld	(OFST+0,sp),a
2302                     ; 594         clockfrequency = HSI_VALUE / presc;
2304  0476 b703          	ld	c_lreg+3,a
2305  0478 3f02          	clr	c_lreg+2
2306  047a 3f01          	clr	c_lreg+1
2307  047c 3f00          	clr	c_lreg
2308  047e 96            	ldw	x,sp
2309  047f 5c            	incw	x
2310  0480 8d000000      	callf	d_rtol
2313  0484 ae2400        	ldw	x,#9216
2314  0487 bf02          	ldw	c_lreg+2,x
2315  0489 ae00f4        	ldw	x,#244
2316  048c bf00          	ldw	c_lreg,x
2317  048e 96            	ldw	x,sp
2318  048f 5c            	incw	x
2319  0490 8d000000      	callf	d_ludv
2321  0494 96            	ldw	x,sp
2322  0495 1c0005        	addw	x,#OFST-4
2323  0498 8d000000      	callf	d_rtol
2327  049c 2018          	jra	L3401
2328  049e               L1401:
2329                     ; 596     else if ( clocksource == CLK_SOURCE_LSI)
2331  049e a1d2          	cp	a,#210
2332  04a0 260a          	jrne	L5401
2333                     ; 598         clockfrequency = LSI_VALUE;
2335  04a2 aef400        	ldw	x,#62464
2336  04a5 1f07          	ldw	(OFST-2,sp),x
2337  04a7 ae0001        	ldw	x,#1
2339  04aa 2008          	jp	LC004
2340  04ac               L5401:
2341                     ; 602         clockfrequency = HSE_VALUE;
2343  04ac ae2400        	ldw	x,#9216
2344  04af 1f07          	ldw	(OFST-2,sp),x
2345  04b1 ae00f4        	ldw	x,#244
2346  04b4               LC004:
2347  04b4 1f05          	ldw	(OFST-4,sp),x
2349  04b6               L3401:
2350                     ; 605     return((uint32_t)clockfrequency);
2352  04b6 96            	ldw	x,sp
2353  04b7 1c0005        	addw	x,#OFST-4
2354  04ba 8d000000      	callf	d_ltor
2358  04be 5b09          	addw	sp,#9
2359  04c0 87            	retf	
2459                     ; 616 void CLK_AdjustHSICalibrationValue(CLK_HSITrimValue_TypeDef CLK_HSICalibrationValue)
2459                     ; 617 {
2460                     	switch	.text
2461  04c1               f_CLK_AdjustHSICalibrationValue:
2463  04c1 88            	push	a
2464       00000000      OFST:	set	0
2467                     ; 620     assert_param(IS_CLK_HSITRIMVALUE_OK(CLK_HSICalibrationValue));
2469  04c2 4d            	tnz	a
2470  04c3 272b          	jreq	L623
2471  04c5 a101          	cp	a,#1
2472  04c7 2727          	jreq	L623
2473  04c9 a102          	cp	a,#2
2474  04cb 2723          	jreq	L623
2475  04cd a103          	cp	a,#3
2476  04cf 271f          	jreq	L623
2477  04d1 a104          	cp	a,#4
2478  04d3 271b          	jreq	L623
2479  04d5 a105          	cp	a,#5
2480  04d7 2717          	jreq	L623
2481  04d9 a106          	cp	a,#6
2482  04db 2713          	jreq	L623
2483  04dd a107          	cp	a,#7
2484  04df 270f          	jreq	L623
2485  04e1 ae026c        	ldw	x,#620
2486  04e4 89            	pushw	x
2487  04e5 5f            	clrw	x
2488  04e6 89            	pushw	x
2489  04e7 ae000c        	ldw	x,#L75
2490  04ea 8d000000      	callf	f_assert_failed
2492  04ee 5b04          	addw	sp,#4
2493  04f0               L623:
2494                     ; 623     CLK->HSITRIMR = (uint8_t)( (uint8_t)(CLK->HSITRIMR & (uint8_t)(~CLK_HSITRIMR_HSITRIM))|((uint8_t)CLK_HSICalibrationValue));
2496  04f0 c650cc        	ld	a,20684
2497  04f3 a4f8          	and	a,#248
2498  04f5 1a01          	or	a,(OFST+1,sp)
2499  04f7 c750cc        	ld	20684,a
2500                     ; 625 }
2503  04fa 84            	pop	a
2504  04fb 87            	retf	
2528                     ; 636 void CLK_SYSCLKEmergencyClear(void)
2528                     ; 637 {
2529                     	switch	.text
2530  04fc               f_CLK_SYSCLKEmergencyClear:
2534                     ; 638     CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWBSY);
2536  04fc 721150c5      	bres	20677,#0
2537                     ; 639 }
2540  0500 87            	retf	
2690                     ; 648 FlagStatus CLK_GetFlagStatus(CLK_Flag_TypeDef CLK_FLAG)
2690                     ; 649 {
2691                     	switch	.text
2692  0501               f_CLK_GetFlagStatus:
2694  0501 89            	pushw	x
2695  0502 5203          	subw	sp,#3
2696       00000003      OFST:	set	3
2699                     ; 651     uint16_t statusreg = 0;
2701                     ; 652     uint8_t tmpreg = 0;
2703                     ; 653     FlagStatus bitstatus = RESET;
2705                     ; 656     assert_param(IS_CLK_FLAG_OK(CLK_FLAG));
2707  0504 a30110        	cpw	x,#272
2708  0507 2737          	jreq	L243
2709  0509 a30102        	cpw	x,#258
2710  050c 2732          	jreq	L243
2711  050e a30202        	cpw	x,#514
2712  0511 272d          	jreq	L243
2713  0513 a30308        	cpw	x,#776
2714  0516 2728          	jreq	L243
2715  0518 a30301        	cpw	x,#769
2716  051b 2723          	jreq	L243
2717  051d a30408        	cpw	x,#1032
2718  0520 271e          	jreq	L243
2719  0522 a30402        	cpw	x,#1026
2720  0525 2719          	jreq	L243
2721  0527 a30504        	cpw	x,#1284
2722  052a 2714          	jreq	L243
2723  052c a30502        	cpw	x,#1282
2724  052f 270f          	jreq	L243
2725  0531 ae0290        	ldw	x,#656
2726  0534 89            	pushw	x
2727  0535 5f            	clrw	x
2728  0536 89            	pushw	x
2729  0537 ae000c        	ldw	x,#L75
2730  053a 8d000000      	callf	f_assert_failed
2732  053e 5b04          	addw	sp,#4
2733  0540               L243:
2734                     ; 659     statusreg = (uint16_t)((uint16_t)CLK_FLAG & (uint16_t)0xFF00);
2736  0540 7b04          	ld	a,(OFST+1,sp)
2737  0542 97            	ld	xl,a
2738  0543 4f            	clr	a
2739  0544 02            	rlwa	x,a
2740  0545 1f01          	ldw	(OFST-2,sp),x
2742                     ; 662     if (statusreg == 0x0100) /* The flag to check is in ICKRregister */
2744  0547 a30100        	cpw	x,#256
2745  054a 2605          	jrne	L7021
2746                     ; 664         tmpreg = CLK->ICKR;
2748  054c c650c0        	ld	a,20672
2750  054f 2021          	jra	L1121
2751  0551               L7021:
2752                     ; 666     else if (statusreg == 0x0200) /* The flag to check is in ECKRregister */
2754  0551 a30200        	cpw	x,#512
2755  0554 2605          	jrne	L3121
2756                     ; 668         tmpreg = CLK->ECKR;
2758  0556 c650c1        	ld	a,20673
2760  0559 2017          	jra	L1121
2761  055b               L3121:
2762                     ; 670     else if (statusreg == 0x0300) /* The flag to check is in SWIC register */
2764  055b a30300        	cpw	x,#768
2765  055e 2605          	jrne	L7121
2766                     ; 672         tmpreg = CLK->SWCR;
2768  0560 c650c5        	ld	a,20677
2770  0563 200d          	jra	L1121
2771  0565               L7121:
2772                     ; 674     else if (statusreg == 0x0400) /* The flag to check is in CSS register */
2774  0565 a30400        	cpw	x,#1024
2775  0568 2605          	jrne	L3221
2776                     ; 676         tmpreg = CLK->CSSR;
2778  056a c650c8        	ld	a,20680
2780  056d 2003          	jra	L1121
2781  056f               L3221:
2782                     ; 680         tmpreg = CLK->CCOR;
2784  056f c650c9        	ld	a,20681
2785  0572               L1121:
2786  0572 6b03          	ld	(OFST+0,sp),a
2788                     ; 683     if ((tmpreg & (uint8_t)CLK_FLAG) != (uint8_t)RESET)
2790  0574 7b05          	ld	a,(OFST+2,sp)
2791  0576 1503          	bcp	a,(OFST+0,sp)
2792  0578 2704          	jreq	L7221
2793                     ; 685         bitstatus = SET;
2795  057a a601          	ld	a,#1
2798  057c 2001          	jra	L1321
2799  057e               L7221:
2800                     ; 689         bitstatus = RESET;
2802  057e 4f            	clr	a
2804  057f               L1321:
2805                     ; 693     return((FlagStatus)bitstatus);
2809  057f 5b05          	addw	sp,#5
2810  0581 87            	retf	
2857                     ; 703 ITStatus CLK_GetITStatus(CLK_IT_TypeDef CLK_IT)
2857                     ; 704 {
2858                     	switch	.text
2859  0582               f_CLK_GetITStatus:
2861  0582 88            	push	a
2862  0583 88            	push	a
2863       00000001      OFST:	set	1
2866                     ; 706     ITStatus bitstatus = RESET;
2868                     ; 709     assert_param(IS_CLK_IT_OK(CLK_IT));
2870  0584 a10c          	cp	a,#12
2871  0586 2713          	jreq	L453
2872  0588 a11c          	cp	a,#28
2873  058a 270f          	jreq	L453
2874  058c ae02c5        	ldw	x,#709
2875  058f 89            	pushw	x
2876  0590 5f            	clrw	x
2877  0591 89            	pushw	x
2878  0592 ae000c        	ldw	x,#L75
2879  0595 8d000000      	callf	f_assert_failed
2881  0599 5b04          	addw	sp,#4
2882  059b               L453:
2883                     ; 711     if (CLK_IT == CLK_IT_SWIF)
2885  059b 7b02          	ld	a,(OFST+1,sp)
2886  059d a11c          	cp	a,#28
2887  059f 260b          	jrne	L5521
2888                     ; 714         if ((CLK->SWCR & (uint8_t)CLK_IT) == (uint8_t)0x0C)
2890  05a1 c650c5        	ld	a,20677
2891  05a4 1402          	and	a,(OFST+1,sp)
2892  05a6 a10c          	cp	a,#12
2893  05a8 260f          	jrne	L5621
2894                     ; 716             bitstatus = SET;
2896  05aa 2009          	jp	LC006
2897                     ; 720             bitstatus = RESET;
2898  05ac               L5521:
2899                     ; 726         if ((CLK->CSSR & (uint8_t)CLK_IT) == (uint8_t)0x0C)
2901  05ac c650c8        	ld	a,20680
2902  05af 1402          	and	a,(OFST+1,sp)
2903  05b1 a10c          	cp	a,#12
2904  05b3 2604          	jrne	L5621
2905                     ; 728             bitstatus = SET;
2907  05b5               LC006:
2909  05b5 a601          	ld	a,#1
2912  05b7 2001          	jra	L3621
2913  05b9               L5621:
2914                     ; 732             bitstatus = RESET;
2917  05b9 4f            	clr	a
2919  05ba               L3621:
2920                     ; 737     return bitstatus;
2924  05ba 85            	popw	x
2925  05bb 87            	retf	
2962                     ; 747 void CLK_ClearITPendingBit(CLK_IT_TypeDef CLK_IT)
2962                     ; 748 {
2963                     	switch	.text
2964  05bc               f_CLK_ClearITPendingBit:
2966  05bc 88            	push	a
2967       00000000      OFST:	set	0
2970                     ; 751     assert_param(IS_CLK_IT_OK(CLK_IT));
2972  05bd a10c          	cp	a,#12
2973  05bf 2713          	jreq	L663
2974  05c1 a11c          	cp	a,#28
2975  05c3 270f          	jreq	L663
2976  05c5 ae02ef        	ldw	x,#751
2977  05c8 89            	pushw	x
2978  05c9 5f            	clrw	x
2979  05ca 89            	pushw	x
2980  05cb ae000c        	ldw	x,#L75
2981  05ce 8d000000      	callf	f_assert_failed
2983  05d2 5b04          	addw	sp,#4
2984  05d4               L663:
2985                     ; 753     if (CLK_IT == (uint8_t)CLK_IT_CSSD)
2987  05d4 7b01          	ld	a,(OFST+1,sp)
2988  05d6 a10c          	cp	a,#12
2989  05d8 2606          	jrne	L7031
2990                     ; 756         CLK->CSSR &= (uint8_t)(~CLK_CSSR_CSSD);
2992  05da 721750c8      	bres	20680,#3
2994  05de 2004          	jra	L1131
2995  05e0               L7031:
2996                     ; 761         CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIF);
2998  05e0 721750c5      	bres	20677,#3
2999  05e4               L1131:
3000                     ; 764 }
3003  05e4 84            	pop	a
3004  05e5 87            	retf	
3039                     	xdef	_CLKPrescTable
3040                     	xdef	_HSIDivFactor
3041                     	xdef	f_CLK_ClearITPendingBit
3042                     	xdef	f_CLK_GetITStatus
3043                     	xdef	f_CLK_GetFlagStatus
3044                     	xdef	f_CLK_GetSYSCLKSource
3045                     	xdef	f_CLK_GetClockFreq
3046                     	xdef	f_CLK_AdjustHSICalibrationValue
3047                     	xdef	f_CLK_SYSCLKEmergencyClear
3048                     	xdef	f_CLK_ClockSecuritySystemEnable
3049                     	xdef	f_CLK_SWIMConfig
3050                     	xdef	f_CLK_SYSCLKConfig
3051                     	xdef	f_CLK_ITConfig
3052                     	xdef	f_CLK_CCOConfig
3053                     	xdef	f_CLK_HSIPrescalerConfig
3054                     	xdef	f_CLK_ClockSwitchConfig
3055                     	xdef	f_CLK_PeripheralClockConfig
3056                     	xdef	f_CLK_SlowActiveHaltWakeUpCmd
3057                     	xdef	f_CLK_FastHaltWakeUpCmd
3058                     	xdef	f_CLK_ClockSwitchCmd
3059                     	xdef	f_CLK_CCOCmd
3060                     	xdef	f_CLK_LSICmd
3061                     	xdef	f_CLK_HSICmd
3062                     	xdef	f_CLK_HSECmd
3063                     	xdef	f_CLK_DeInit
3064                     	xref	f_assert_failed
3065                     	switch	.const
3066  000c               L75:
3067  000c 2e2e5c2e2e5c  	dc.b	"..\..\..\..\librar"
3068  001e 6965735c7374  	dc.b	"ies\stm8s_stdperip"
3069  0030 685f64726976  	dc.b	"h_driver\src\stm8s"
3070  0042 5f636c6b2e63  	dc.b	"_clk.c",0
3071                     	xref.b	c_lreg
3072                     	xref.b	c_x
3092                     	xref	d_ltor
3093                     	xref	d_ludv
3094                     	xref	d_rtol
3095                     	end
