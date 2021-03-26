/**
  ******************************************************************************
  *  IM_ADC2v2-2с.c
  *  Gorbachevskiy
  *  version 1
  *  date    24.01.2021
  *  ADC верс2 модификация 2 rel=02
  *  *  работа с 2-я каналами ровно с фоновым переключением каналов
  ******************************************************************************
   */
    
#include "IM_ADC2v2-2c.h"
#include "stm8s_adc2.h"
#include "string.h"
//#include "IM_tim4.h"
#include "IM_intr_spec.h"




// результаты измерений АЦП [0]-для канала 0, [1] - для канала 1

IM_ADC_R IM_ADCr[2];//массив структур 

#if 0
struct //внешняя структура
{
   u8    fA;   // =1 - измерений результат обновился
   float A;  // результат измерения после усреднения
	 u16   IA; // *10
   /// диагностика
   u8 FN;          // =1 результат дигностики обновился
   u16 N,Ns;     //  счетчик результатов всего и за секунду( Обновляется один раз в секунду)         
} IM_ADC_R; 
#endif

// внутренняя структуа
 struct 
{
 u8     CnAI;     // 0,1 - тег логический ном канала для прерываний 
 u8     NCn[2];   // массив физических номеров каналов
 u8     NLCn[2];  // цепочка переключений NLCn[x] = ЛогНомСледКанала 
 
 u16     ns[2];   // заданное число усреднений по каналами
 float  fns[2];   // =1/ns
 
 u32      aI; // текущая сумма показаний АЦП для усреднения внутри прерывания
 u16    cntI; //  текущий счетчик измерений , внутри прерывания
 
 u32       a[2];  // набранная сумма показаний АЦП для усреднения 
 u16     cnt[2];  //  реальный счетчик измерений  
 u8       fL[2];    // признак - =1 сумма набралась, 
 u32    cnt_[2];  // счетчики результатов усредненных измерений

 u16 tmpI; // чтение АЦП в прерываниях
 u32 cntII;        // общий счетчик прерываний-измерений

} IM_ADCrab ;   // IM_ADCrab.NCn pr1


////////////////////////////////////////////////////////////
//  прерывания
 INTERRUPT_HANDLER(ADC2_IRQHandler, 22)
{
// 

IM_ADCrab.cntI++;
IM_ADCrab.cntII++;


*(((char*)&IM_ADCrab.tmpI)+1)      = ADC2->DRL;      // сначала  DRL
*(((char*)&IM_ADCrab.tmpI)+0)      = ADC2->DRH;      // потом DRH
 


 if (IM_ADCrab.CnAI==0)            //  0-канал!! 0000000000000000000000000000000000000000000000
 {
  IM_ADCrab.aI += IM_ADCrab.tmpI;
  
     if(IM_ADCrab.cntI >= IM_ADCrab.ns[0]) // набрали сумму 
   
	   {
       IM_ADCrab.a[0]   = IM_ADCrab.aI;          // ADC
       IM_ADCrab.cnt[0] = IM_ADCrab.cntI;       // счетчик
       IM_ADCrab.fL[0] = 1;                     // признак завершения
       IM_ADCrab.aI = IM_ADCrab.cntI=0;    // обнулились для след преобразования
       
			 //  перекл после усреднения
       // следующий  канал                   // !!!!!!!!!!!!!!!!!!!!!!!!!!!!! 
       IM_ADCrab.CnAI= IM_ADCrab.NLCn[1];    // след логический канал IM_ADCrab.NLCn[]
			 ADC2->CSR &= (uint8_t)(~ADC2_CSR_CH); //  Clear the ADC2 channels 
			 /* след физ канал  */
       ADC2->CSR |= (uint8_t)(IM_ADCrab.NCn[1]); //Select the ADC2 channel
			                                      
       
			 }   
   
 }
 else
  if (IM_ADCrab.CnAI==1)            //  1-канал!! 0000000000000000000000000000000000000000000000
 {
  IM_ADCrab.aI += IM_ADCrab.tmpI;
  
  
     if(IM_ADCrab.cntI >= IM_ADCrab.ns[1]) // набрали сумму 
   
	   {
       IM_ADCrab.a[1]   = IM_ADCrab.aI;          // ADC
       IM_ADCrab.cnt[1] = IM_ADCrab.cntI;       // счетчик
       IM_ADCrab.fL[1] = 1;                     // признак завершения
       IM_ADCrab.aI = IM_ADCrab.cntI=0;    // обнулились для след преобразования
       
			 //  перекл после усреднения
       // следующий  канал                   // !!!!!!!!!!!!!!!!!!!!!!!!!!!!! 
       IM_ADCrab.CnAI= IM_ADCrab.NLCn[0];    // след логический канал IM_ADCrab.NLCn[]
			 ADC2->CSR &= (uint8_t)(~ADC2_CSR_CH); //  Clear the ADC2 channels 
			 /* след физ канал  */
       ADC2->CSR |= (uint8_t)(IM_ADCrab.NCn[0]); //Select the ADC2 channel
			 }   
   
 }
        // сброс прерывания  =  ADC2_ClearITPendingBit(); 
        // ADC2_ClearITPendingBit(); 
				 ADC2->CSR &= (uint8_t)(~ADC2_CSR_EOC);//BRES  0x5400,#7   !!!!!    
         
        /// запуск след  преобразования  = 
        //  ADC2_StartConversion();
          ADC2->CR1 |= ADC2_CR1_ADON;        //BSET  0x5401,#0 !!!!!
}
//////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////
// функция для конфигурирования АЦП2

void IM_ADC_Config(u16 Lsr0,   //количество усреднений по 0 каналу, если 0 - то 1
                   u16 Lsr1,   //количество усреднений по 1 каналу, если 0 - то 1
                   u8 ch0, //физ канал 0-го логического канала (0-7)
                   u8 ch1,   //физ канал 0-го логического канала (0-7)
                   u8  prsc    // Prescaler работы АСП <=7, если больше, то =7 
                   )
{
ADC2_Channel_TypeDef Ch;

  ADC2_DeInit();//Деинициализирует периферийные регистры ADC2
								//до их сброса значений по умолчанию.

//IM_ADCr и IM_ADCrab - обнулить
  memset(&IM_ADCr,0,sizeof(IM_ADCr));
  memset(&IM_ADCrab,0,sizeof(IM_ADCrab));

if (Lsr0==0)Lsr0=1;
if (Lsr1==0)Lsr1=1;


if (Lsr0>2000)Lsr0=2000;
if (Lsr1>2000)Lsr1=2000;


IM_ADCrab.ns[0]=Lsr0;
IM_ADCrab.ns[1]=Lsr1;


// float      fns0,fns1; // =1/ns
IM_ADCrab.fns[0] = 1./Lsr0;
IM_ADCrab.fns[1] = 1./Lsr1;


  if (prsc >= 7) prsc=7;
  prsc =(u8) (prsc<<((u8)4));    // такой формат ADC2_PresSel_TypeDef
   

  //////////////////////////////////////////
	GPIO_Init(GPIOB, (GPIO_Pin_TypeDef)GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);
	GPIO_Init(GPIOB, (GPIO_Pin_TypeDef)GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);
	
  // в соответсвии с настроенными ногами !!!!!
  // логический канал = физический канал АЦП =
  //                    номер пина порт Вх GPIO_PIN_х
     IM_ADCrab.NCn[0] =   ch0;
     IM_ADCrab.NCn[1] =   ch1;

	   IM_ADCrab.NLCn[0] = 0; // после работы с нулевым каналом в прерываниях
		                        // надо перекл на "1" лог канал!!
		 IM_ADCrab.NLCn[1] = 1;
//  
//
//
//

	ADC2_Init( ADC2_CONVERSIONMODE_SINGLE , // каждое преобр нужно запускать вручную
	           IM_ADCrab.NCn[0],   // номер канала - задаем
	           //ADC2_PRESSEL_FCPU_Dx,        // скорость преобразования - задаем
	           (ADC2_PresSel_TypeDef)prsc, 
	           ADC2_EXTTRIG_TIM, DISABLE,   // всегда откл
	           ADC2_ALIGN_RIGHT,            // всегда прижато вправо!
	           ADC2_SCHMITTTRIG_CHANNEL1,DISABLE);   //всегда откл
				 
	
  ADC2_ITConfig(ENABLE);    // прерывания разрешены
  ADC2_Cmd(ENABLE);         // АЦП разрешено
  ADC2_StartConversion();   // старт первого преобразования
	
}



////////////////////////////////////////////////////////////////////
// 1- был хотя бы 1 результат в IM_ADCr
// искать по флагу IM_ADCr[i].fA = 1; 
u8 IM_ADC_handler(void)//данная функция используется для работы с АЦП
{
////////////////////////////////////////////
  u32  aa; 
  u8 i,ii=0;
  for(i=0;i<2;i++)
  {
    if(IM_ADCrab.fL[i]==1)  
    {
		disableInterrupts();//запрет прерываний
     aa = IM_ADCrab.a[i];
     IM_ADCrab.fL[i] = 0;
		 
		enableInterrupts();// разрешение прерываний
		 IM_ADCrab.cnt_[i]++;

     IM_ADCr[i].fA = 1;   // флаг результата
     IM_ADCr[i].A  = aa* IM_ADCrab.fns[i]  ;  // усреднение
	   IM_ADCr[i].IA = (u16)(IM_ADCr[i].A*10.+0.5);
     IM_ADCr[i].N++;              // счетчик результатов по каналу
	   ii=1;
		}

  } // for
 return ii ;  // 1- был хотя бы 1 результат
}