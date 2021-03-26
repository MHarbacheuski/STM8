   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.13 - 05 Feb 2019
   3                     ; Generator (Limited) V4.4.9 - 06 Feb 2019
   4                     ; Optimizer V4.4.9 - 06 Feb 2019
  58                     ; 22 void main(void)
  58                     ; 23 {
  60                     	switch	.text
  61  0000               f_main:
  65                     ; 24  kkk=0xff;
  67  0000 35ff000c      	mov	_kkk,#255
  68                     ; 25  NT1 =100;
  70  0004 35640000      	mov	_NT1,#100
  71                     ; 26  n=NT1;
  73  0008 3564000f      	mov	_n,#100
  74                     ; 28 k1=k2=0;  // остановка 1 - сбросить врем€ User clock
  76  000c 725f000d      	clr	_k2
  77  0010 725f000e      	clr	_k1
  78                     ; 33 for (i=0;i<n;i++)
  80  0014 725f0011      	clr	_i
  82  0018 203c          	jra	L52
  83  001a               L12:
  84                     ; 35 	W=T1[i];   //  на совпадение
  86  001a c60011        	ld	a,_i
  87  001d 5f            	clrw	x
  88  001e 97            	ld	xl,a
  89  001f 58            	sllw	x
  90  0020 de0000        	ldw	x,(_T1,x)
  91  0023 cf000a        	ldw	_W,x
  92                     ; 37   j=i;        // вместо вызова
  94  0026 5500110010    	mov	_j,_i
  95                     ; 38 	if( j == i)
  97  002b c60010        	ld	a,_j
  98  002e c10011        	cp	a,_i
  99  0031 2604          	jrne	L13
 100                     ; 39 	  k1++ ;      // подсчет совпадений дл€ контрол€
 102  0033 725c000e      	inc	_k1
 103  0037               L13:
 104                     ; 43 	W=T2[i];   //  на  Ќ≈ совпадение
 106  0037 c60011        	ld	a,_i
 107  003a 5f            	clrw	x
 108  003b 97            	ld	xl,a
 109  003c 58            	sllw	x
 110  003d de0000        	ldw	x,(_T2,x)
 111  0040 cf000a        	ldw	_W,x
 112                     ; 45   j=kkk;	
 114  0043 55000c0010    	mov	_j,_kkk
 115                     ; 46 	if( j == 0xff)
 117  0048 c60010        	ld	a,_j
 118  004b 4c            	inc	a
 119  004c 2604          	jrne	L33
 120                     ; 47 	  k2++ ;      // подсчет совпадений дл€ контрол€
 122  004e 725c000d      	inc	_k2
 123  0052               L33:
 124                     ; 33 for (i=0;i<n;i++)
 126  0052 725c0011      	inc	_i
 127  0056               L52:
 130  0056 c60011        	ld	a,_i
 131  0059 c1000f        	cp	a,_n
 132  005c 25bc          	jrult	L12
 133                     ; 49 k1=k2=0;  // остановка - замер "тары", сброс User clock
 135  005e 725f000d      	clr	_k2
 136  0062 725f000e      	clr	_k1
 137                     ; 52 for (i=0;i<n;i++)
 139  0066 725f0011      	clr	_i
 141  006a 2046          	jra	L14
 142  006c               L53:
 143                     ; 54 	W=T1[i];   //  на совпадение
 145  006c c60011        	ld	a,_i
 146  006f 5f            	clrw	x
 147  0070 97            	ld	xl,a
 148  0071 58            	sllw	x
 149  0072 de0000        	ldw	x,(_T1,x)
 150  0075 cf000a        	ldw	_W,x
 151                     ; 55 	j=bp_f4(W); 
 153  0078 ce000a        	ldw	x,_W
 154  007b 8d000000      	callf	f_bp_f4
 156  007f c70010        	ld	_j,a
 157                     ; 59 	if( j == i)
 159  0082 c60010        	ld	a,_j
 160  0085 c10011        	cp	a,_i
 161  0088 2604          	jrne	L54
 162                     ; 60 	  k1++ ;      // подсчет совпадений дл€ контрол€
 164  008a 725c000e      	inc	_k1
 165  008e               L54:
 166                     ; 64 	W=T2[i];   //  на  Ќ≈ совпадение
 168  008e c60011        	ld	a,_i
 169  0091 5f            	clrw	x
 170  0092 97            	ld	xl,a
 171  0093 58            	sllw	x
 172  0094 de0000        	ldw	x,(_T2,x)
 173  0097 cf000a        	ldw	_W,x
 174                     ; 65 	j=bp_f4(W);
 176  009a ce000a        	ldw	x,_W
 177  009d 8d000000      	callf	f_bp_f4
 179  00a1 c70010        	ld	_j,a
 180                     ; 69 	if( j == 0xff)
 182  00a4 c60010        	ld	a,_j
 183  00a7 4c            	inc	a
 184  00a8 2604          	jrne	L74
 185                     ; 70 	  k2++ ;      // подсчет совпадений дл€ контрол€
 187  00aa 725c000d      	inc	_k2
 188  00ae               L74:
 189                     ; 52 for (i=0;i<n;i++)
 191  00ae 725c0011      	inc	_i
 192  00b2               L14:
 195  00b2 c60011        	ld	a,_i
 196  00b5 c1000f        	cp	a,_n
 197  00b8 25b2          	jrult	L53
 198                     ; 72 i=j;  // остановка - замер раб цикла, не забыть отн€ть тару
 200  00ba 5500100011    	mov	_i,_j
 201  00bf               L15:
 202                     ; 86 while(1);
 204  00bf 20fe          	jra	L15
 260                     ; 94 void CLK_Config(void)
 260                     ; 95 {
 261                     	switch	.text
 262  00c1               f_CLK_Config:
 264  00c1 88            	push	a
 265       00000001      OFST:	set	1
 268                     ; 97 	ErrorStatus status = ERROR;
 270                     ; 102 	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 272  00c2 4f            	clr	a
 273  00c3 8d000000      	callf	f_CLK_HSIPrescalerConfig
 275                     ; 105 }
 278  00c7 84            	pop	a
 279  00c8 87            	retf	
 314                     ; 126 void assert_failed(uint8_t* file, uint32_t line)
 314                     ; 127 { 
 315                     	switch	.text
 316  00c9               f_assert_failed:
 320  00c9               L121:
 321  00c9 20fe          	jra	L121
 353                     ; 26 INTERRUPT_HANDLER(NonHandledInterrupt, 25)
 353                     ; 27 {
 354                     	switch	.text
 355  00cb               f_NonHandledInterrupt:
 359                     ; 31 }
 362  00cb 80            	iret	
 385                     ; 39 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
 385                     ; 40 {
 386                     	switch	.text
 387  00cc               f_TRAP_IRQHandler:
 391                     ; 45 }
 394  00cc 80            	iret	
 417                     ; 51 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
 417                     ; 52 {
 418                     	switch	.text
 419  00cd               f_TLI_IRQHandler:
 423                     ; 56 }
 426  00cd 80            	iret	
 449                     ; 63 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
 449                     ; 64 {
 450                     	switch	.text
 451  00ce               f_AWU_IRQHandler:
 455                     ; 68 }
 458  00ce 80            	iret	
 481                     ; 75 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 481                     ; 76 {
 482                     	switch	.text
 483  00cf               f_CLK_IRQHandler:
 487                     ; 80 }
 490  00cf 80            	iret	
 514                     ; 87 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 514                     ; 88 {
 515                     	switch	.text
 516  00d0               f_EXTI_PORTA_IRQHandler:
 520                     ; 92 }
 523  00d0 80            	iret	
 547                     ; 99 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 547                     ; 100 {
 548                     	switch	.text
 549  00d1               f_EXTI_PORTB_IRQHandler:
 553                     ; 104 }
 556  00d1 80            	iret	
 580                     ; 111 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 580                     ; 112 {
 581                     	switch	.text
 582  00d2               f_EXTI_PORTC_IRQHandler:
 586                     ; 116 }
 589  00d2 80            	iret	
 613                     ; 123 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 613                     ; 124 {
 614                     	switch	.text
 615  00d3               f_EXTI_PORTD_IRQHandler:
 619                     ; 128 }
 622  00d3 80            	iret	
 646                     ; 135 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 646                     ; 136 {
 647                     	switch	.text
 648  00d4               f_EXTI_PORTE_IRQHandler:
 652                     ; 143 }
 655  00d4 80            	iret	
 678                     ; 166  INTERRUPT_HANDLER(CAN_RX_IRQHandler, 8)
 678                     ; 167 {
 679                     	switch	.text
 680  00d5               f_CAN_RX_IRQHandler:
 684                     ; 172 }
 687  00d5 80            	iret	
 710                     ; 179  INTERRUPT_HANDLER(CAN_TX_IRQHandler, 9)
 710                     ; 180 {
 711                     	switch	.text
 712  00d6               f_CAN_TX_IRQHandler:
 716                     ; 187 }
 719  00d6 80            	iret	
 742                     ; 195 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 742                     ; 196 {
 743                     	switch	.text
 744  00d7               f_SPI_IRQHandler:
 748                     ; 200 }
 751  00d7 80            	iret	
 775                     ; 208 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 775                     ; 209 {
 776                     	switch	.text
 777  00d8               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 781                     ; 215 }
 784  00d8 80            	iret	
 808                     ; 222 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
 808                     ; 223 {
 809                     	switch	.text
 810  00d9               f_TIM1_CAP_COM_IRQHandler:
 814                     ; 227 }
 817  00d9 80            	iret	
 841                     ; 259  INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 841                     ; 260 {
 842                     	switch	.text
 843  00da               f_TIM2_UPD_OVF_BRK_IRQHandler:
 847                     ; 264 }
 850  00da 80            	iret	
 874                     ; 271  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 874                     ; 272 {
 875                     	switch	.text
 876  00db               f_TIM2_CAP_COM_IRQHandler:
 880                     ; 276 }
 883  00db 80            	iret	
 907                     ; 288  INTERRUPT_HANDLER(TIM3_UPD_OVF_BRK_IRQHandler, 15)
 907                     ; 289 {
 908                     	switch	.text
 909  00dc               f_TIM3_UPD_OVF_BRK_IRQHandler:
 913                     ; 291 }
 916  00dc 80            	iret	
 940                     ; 298  INTERRUPT_HANDLER(TIM3_CAP_COM_IRQHandler, 16)
 940                     ; 299 {
 941                     	switch	.text
 942  00dd               f_TIM3_CAP_COM_IRQHandler:
 946                     ; 302 }
 949  00dd 80            	iret	
 973                     ; 312  INTERRUPT_HANDLER(UART1_TX_IRQHandler, 17)
 973                     ; 313 {
 974                     	switch	.text
 975  00de               f_UART1_TX_IRQHandler:
 979                     ; 317 }
 982  00de 80            	iret	
1006                     ; 324  INTERRUPT_HANDLER(UART1_RX_IRQHandler, 18)
1006                     ; 325 {
1007                     	switch	.text
1008  00df               f_UART1_RX_IRQHandler:
1012                     ; 329 }
1015  00df 80            	iret	
1038                     ; 337 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
1038                     ; 338 {
1039                     	switch	.text
1040  00e0               f_I2C_IRQHandler:
1044                     ; 342 }
1047  00e0 80            	iret	
1071                     ; 376  INTERRUPT_HANDLER(UART3_TX_IRQHandler, 20)
1071                     ; 377 {
1072                     	switch	.text
1073  00e1               f_UART3_TX_IRQHandler:
1077                     ; 381   }
1080  00e1 80            	iret	
1104                     ; 388  INTERRUPT_HANDLER(UART3_RX_IRQHandler, 21)
1104                     ; 389 {
1105                     	switch	.text
1106  00e2               f_UART3_RX_IRQHandler:
1110                     ; 394   }
1113  00e2 80            	iret	
1136                     ; 404  INTERRUPT_HANDLER(ADC2_IRQHandler, 22)
1136                     ; 405 {
1137                     	switch	.text
1138  00e3               f_ADC2_IRQHandler:
1142                     ; 407 }
1145  00e3 80            	iret	
1169                     ; 442  INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
1169                     ; 443 {
1170                     	switch	.text
1171  00e4               f_TIM4_UPD_OVF_IRQHandler:
1175                     ; 445 }
1178  00e4 80            	iret	
1202                     ; 456 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
1202                     ; 457 {
1203                     	switch	.text
1204  00e5               f_EEPROM_EEC_IRQHandler:
1208                     ; 461 }
1211  00e5 80            	iret	
1335                     	switch	.bss
1336  0000               _timeav:
1337  0000 0000          	ds.b	2
1338                     	xdef	_timeav
1339  0002               _time_adc:
1340  0002 0000          	ds.b	2
1341                     	xdef	_time_adc
1342  0004               _timewdt:
1343  0004 0000          	ds.b	2
1344                     	xdef	_timewdt
1345  0006               _time_can:
1346  0006 0000          	ds.b	2
1347                     	xdef	_time_can
1348  0008               _time001:
1349  0008 0000          	ds.b	2
1350                     	xdef	_time001
1351                     	xdef	f_EEPROM_EEC_IRQHandler
1352                     	xdef	f_TIM4_UPD_OVF_IRQHandler
1353                     	xdef	f_ADC2_IRQHandler
1354                     	xdef	f_UART3_TX_IRQHandler
1355                     	xdef	f_UART3_RX_IRQHandler
1356                     	xdef	f_I2C_IRQHandler
1357                     	xdef	f_UART1_RX_IRQHandler
1358                     	xdef	f_UART1_TX_IRQHandler
1359                     	xdef	f_TIM3_CAP_COM_IRQHandler
1360                     	xdef	f_TIM3_UPD_OVF_BRK_IRQHandler
1361                     	xdef	f_TIM2_CAP_COM_IRQHandler
1362                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
1363                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
1364                     	xdef	f_TIM1_CAP_COM_IRQHandler
1365                     	xdef	f_SPI_IRQHandler
1366                     	xdef	f_CAN_TX_IRQHandler
1367                     	xdef	f_CAN_RX_IRQHandler
1368                     	xdef	f_EXTI_PORTE_IRQHandler
1369                     	xdef	f_EXTI_PORTD_IRQHandler
1370                     	xdef	f_EXTI_PORTC_IRQHandler
1371                     	xdef	f_EXTI_PORTB_IRQHandler
1372                     	xdef	f_EXTI_PORTA_IRQHandler
1373                     	xdef	f_CLK_IRQHandler
1374                     	xdef	f_AWU_IRQHandler
1375                     	xdef	f_TLI_IRQHandler
1376                     	xdef	f_TRAP_IRQHandler
1377                     	xdef	f_NonHandledInterrupt
1378                     	xdef	f_CLK_Config
1379                     	xdef	f_main
1380  000a               _W:
1381  000a 0000          	ds.b	2
1382                     	xdef	_W
1383  000c               _kkk:
1384  000c 00            	ds.b	1
1385                     	xdef	_kkk
1386  000d               _k2:
1387  000d 00            	ds.b	1
1388                     	xdef	_k2
1389  000e               _k1:
1390  000e 00            	ds.b	1
1391                     	xdef	_k1
1392  000f               _n:
1393  000f 00            	ds.b	1
1394                     	xdef	_n
1395  0010               _j:
1396  0010 00            	ds.b	1
1397                     	xdef	_j
1398  0011               _i:
1399  0011 00            	ds.b	1
1400                     	xdef	_i
1401                     	xref	f_bp_f4
1402                     	xref	_T2
1403                     	xref	_NT1
1404                     	xref	_T1
1405                     	xdef	f_assert_failed
1406                     	xref	f_CLK_HSIPrescalerConfig
1426                     	end
