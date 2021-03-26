#include "main.h"
#include "stm8s.h"

///////////
extern u16 T1[100]; // таблица по которой ищем
extern u8 NT1;
extern u16 T2[100]; // таблица значений которых нет в Т1 - для несовпадений

/////////////////
//u8 NT1 = 100;

u8 b_f(u16 A);  // A - что ищем по таблице T1  длиной NT1 
u8 b_f1(u16 A); //тест первый, уменьшаем число if
u8 b_f2(u16 A); //тест второй, уменьшение обращений к индексированным переменным
u8 b_f3(u16 A); //тест третий, объявим переменные глобальными
u8 P_f(u16 A);//последовательный поиск
u8 bp_f4(u16 A);// гибридный поиск
////////////////////////////////////////////
volatile u8 i,j,n,k1,k2,kkk; //для дебагера лучше объявлять наверху
volatile u16 W;

void main(void)
{
 kkk=0xff;
 NT1 =100;
 n=NT1;
 
k1=k2=0;  // остановка 1 - сбросить время User clock
          // в Core Registr
          // стоя здесь можно в Watch поменятьNT1
					// в меньшую сторону
//  "тара" - тестовый цикл без вызова функции поиска 
for (i=0;i<n;i++)
 {
	W=T1[i];   //  на совпадение
	//j=b_f(W); 
  j=i;        // вместо вызова
	if( j == i)
	  k1++ ;      // подсчет совпадений для контроля
		           // мы будем модифицировать модуль и надо будет посматривать 
							// чтоб не было ошибок
 ///////
	W=T2[i];   //  на  НЕ совпадение
	//j=b_f(W);
  j=kkk;	
	if( j == 0xff)
	  k2++ ;      // подсчет совпадений для контроля
 }
k1=k2=0;  // остановка - замер "тары", сброс User clock
//////////////
//  рабочий цикл ///// 
for (i=0;i<n;i++)
 {
	W=T1[i];   //  на совпадение
	j=bp_f4(W); 
  //j=P_f(W);
	
  //j=i;        // вместо вызова
	if( j == i)
	  k1++ ;      // подсчет совпадений для контроля
		           // мы будем модифицировать модуль и надо будет посматривать 
							// чтоб не было ошибок
 ///////
	W=T2[i];   //  на  НЕ совпадение
	j=bp_f4(W);
	//j=P_f(W);
	
  //j=kkk;	
	if( j == 0xff)
	  k2++ ;      // подсчет совпадений для контроля
 }
i=j;  // остановка - замер раб цикла, не забыть отнять тару













while(1);



}

//////////////////////////////////

void CLK_Config(void)
{
      //  volatile u8 a,b;
	ErrorStatus status = ERROR;
	
	/* Initialization of the clock */
	/* Clock divider to HSI/1 */
        //  CLK->CKDIVR = 0x00;
	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
  

}


/**
  * @brief  < Add here the function description >
  * @note   < OPTIONAL: add here global note >
  * @param  None 
  * @retval None
  */




#ifdef USE_FULL_ASSERT
/**
  * @brief  Reports the name of the source file and the source line number
  *   where the assert_param error has occurred.
  * @param file: pointer to the source file name
  * @param line: assert_param error line source number
  * @retval None
  */
void assert_failed(uint8_t* file, uint32_t line)
{ 
  /* User can add his own implementation to report the file name and line number,
     ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */

  /* Infinite loop */
  while (1)
  {
  }
}
#endif

/////////////////////////////////////////////////
#include "stm8s_it.c"


/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
	
