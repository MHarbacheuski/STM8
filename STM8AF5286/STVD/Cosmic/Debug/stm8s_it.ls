   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
  45                     ; 26 INTERRUPT_HANDLER(NonHandledInterrupt, 25)
  45                     ; 27 {
  47                     	switch	.text
  48  0000               f_NonHandledInterrupt:
  52                     ; 31 }
  55  0000 80            	iret
  78                     ; 39 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
  78                     ; 40 {
  79                     	switch	.text
  80  0001               f_TRAP_IRQHandler:
  84                     ; 45 }
  87  0001 80            	iret
 110                     ; 51 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
 110                     ; 52 {
 111                     	switch	.text
 112  0002               f_TLI_IRQHandler:
 116                     ; 56 }
 119  0002 80            	iret
 142                     ; 63 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
 142                     ; 64 {
 143                     	switch	.text
 144  0003               f_AWU_IRQHandler:
 148                     ; 68 }
 151  0003 80            	iret
 174                     ; 75 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 174                     ; 76 {
 175                     	switch	.text
 176  0004               f_CLK_IRQHandler:
 180                     ; 80 }
 183  0004 80            	iret
 207                     ; 87 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 207                     ; 88 {
 208                     	switch	.text
 209  0005               f_EXTI_PORTA_IRQHandler:
 213                     ; 92 }
 216  0005 80            	iret
 240                     ; 99 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 240                     ; 100 {
 241                     	switch	.text
 242  0006               f_EXTI_PORTB_IRQHandler:
 246                     ; 104 }
 249  0006 80            	iret
 273                     ; 111 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 273                     ; 112 {
 274                     	switch	.text
 275  0007               f_EXTI_PORTC_IRQHandler:
 279                     ; 116 }
 282  0007 80            	iret
 306                     ; 123 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 306                     ; 124 {
 307                     	switch	.text
 308  0008               f_EXTI_PORTD_IRQHandler:
 312                     ; 128 }
 315  0008 80            	iret
 339                     ; 135 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 339                     ; 136 {
 340                     	switch	.text
 341  0009               f_EXTI_PORTE_IRQHandler:
 345                     ; 143 }
 348  0009 80            	iret
 371                     ; 166  INTERRUPT_HANDLER(CAN_RX_IRQHandler, 8)
 371                     ; 167 {
 372                     	switch	.text
 373  000a               f_CAN_RX_IRQHandler:
 377                     ; 172 }
 380  000a 80            	iret
 403                     ; 179  INTERRUPT_HANDLER(CAN_TX_IRQHandler, 9)
 403                     ; 180 {
 404                     	switch	.text
 405  000b               f_CAN_TX_IRQHandler:
 409                     ; 187 }
 412  000b 80            	iret
 435                     ; 195 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 435                     ; 196 {
 436                     	switch	.text
 437  000c               f_SPI_IRQHandler:
 441                     ; 200 }
 444  000c 80            	iret
 468                     ; 208 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 468                     ; 209 {
 469                     	switch	.text
 470  000d               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 474                     ; 215 }
 477  000d 80            	iret
 501                     ; 222 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
 501                     ; 223 {
 502                     	switch	.text
 503  000e               f_TIM1_CAP_COM_IRQHandler:
 507                     ; 227 }
 510  000e 80            	iret
 534                     ; 259  INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 534                     ; 260 {
 535                     	switch	.text
 536  000f               f_TIM2_UPD_OVF_BRK_IRQHandler:
 540                     ; 264 }
 543  000f 80            	iret
 567                     ; 271  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 567                     ; 272 {
 568                     	switch	.text
 569  0010               f_TIM2_CAP_COM_IRQHandler:
 573                     ; 276 }
 576  0010 80            	iret
 600                     ; 288  INTERRUPT_HANDLER(TIM3_UPD_OVF_BRK_IRQHandler, 15)
 600                     ; 289 {
 601                     	switch	.text
 602  0011               f_TIM3_UPD_OVF_BRK_IRQHandler:
 606                     ; 291 }
 609  0011 80            	iret
 633                     ; 298  INTERRUPT_HANDLER(TIM3_CAP_COM_IRQHandler, 16)
 633                     ; 299 {
 634                     	switch	.text
 635  0012               f_TIM3_CAP_COM_IRQHandler:
 639                     ; 302 }
 642  0012 80            	iret
 666                     ; 312  INTERRUPT_HANDLER(UART1_TX_IRQHandler, 17)
 666                     ; 313 {
 667                     	switch	.text
 668  0013               f_UART1_TX_IRQHandler:
 672                     ; 317 }
 675  0013 80            	iret
 699                     ; 324  INTERRUPT_HANDLER(UART1_RX_IRQHandler, 18)
 699                     ; 325 {
 700                     	switch	.text
 701  0014               f_UART1_RX_IRQHandler:
 705                     ; 329 }
 708  0014 80            	iret
 731                     ; 337 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 731                     ; 338 {
 732                     	switch	.text
 733  0015               f_I2C_IRQHandler:
 737                     ; 342 }
 740  0015 80            	iret
 764                     ; 376  INTERRUPT_HANDLER(UART3_TX_IRQHandler, 20)
 764                     ; 377 {
 765                     	switch	.text
 766  0016               f_UART3_TX_IRQHandler:
 770                     ; 381   }
 773  0016 80            	iret
 797                     ; 388  INTERRUPT_HANDLER(UART3_RX_IRQHandler, 21)
 797                     ; 389 {
 798                     	switch	.text
 799  0017               f_UART3_RX_IRQHandler:
 803                     ; 394   }
 806  0017 80            	iret
 829                     ; 404  INTERRUPT_HANDLER(ADC2_IRQHandler, 22)
 829                     ; 405 {
 830                     	switch	.text
 831  0018               f_ADC2_IRQHandler:
 835                     ; 407 }
 838  0018 80            	iret
 862                     ; 442  INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
 862                     ; 443 {
 863                     	switch	.text
 864  0019               f_TIM4_UPD_OVF_IRQHandler:
 868                     ; 445 }
 871  0019 80            	iret
 895                     ; 456 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
 895                     ; 457 {
 896                     	switch	.text
 897  001a               f_EEPROM_EEC_IRQHandler:
 901                     ; 461 }
 904  001a 80            	iret
 954                     	switch	.bss
 955  0000               _timeav:
 956  0000 0000          	ds.b	2
 957                     	xdef	_timeav
 958  0002               _time_adc:
 959  0002 0000          	ds.b	2
 960                     	xdef	_time_adc
 961  0004               _timewdt:
 962  0004 0000          	ds.b	2
 963                     	xdef	_timewdt
 964  0006               _time_can:
 965  0006 0000          	ds.b	2
 966                     	xdef	_time_can
 967  0008               _time001:
 968  0008 0000          	ds.b	2
 969                     	xdef	_time001
 970                     	xdef	f_EEPROM_EEC_IRQHandler
 971                     	xdef	f_TIM4_UPD_OVF_IRQHandler
 972                     	xdef	f_ADC2_IRQHandler
 973                     	xdef	f_UART3_TX_IRQHandler
 974                     	xdef	f_UART3_RX_IRQHandler
 975                     	xdef	f_I2C_IRQHandler
 976                     	xdef	f_UART1_RX_IRQHandler
 977                     	xdef	f_UART1_TX_IRQHandler
 978                     	xdef	f_TIM3_CAP_COM_IRQHandler
 979                     	xdef	f_TIM3_UPD_OVF_BRK_IRQHandler
 980                     	xdef	f_TIM2_CAP_COM_IRQHandler
 981                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
 982                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
 983                     	xdef	f_TIM1_CAP_COM_IRQHandler
 984                     	xdef	f_SPI_IRQHandler
 985                     	xdef	f_CAN_TX_IRQHandler
 986                     	xdef	f_CAN_RX_IRQHandler
 987                     	xdef	f_EXTI_PORTE_IRQHandler
 988                     	xdef	f_EXTI_PORTD_IRQHandler
 989                     	xdef	f_EXTI_PORTC_IRQHandler
 990                     	xdef	f_EXTI_PORTB_IRQHandler
 991                     	xdef	f_EXTI_PORTA_IRQHandler
 992                     	xdef	f_CLK_IRQHandler
 993                     	xdef	f_AWU_IRQHandler
 994                     	xdef	f_TLI_IRQHandler
 995                     	xdef	f_TRAP_IRQHandler
 996                     	xdef	f_NonHandledInterrupt
1016                     	end
