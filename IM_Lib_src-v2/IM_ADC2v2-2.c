/**
  ******************************************************************************
  *     IM_ADC2v2-2.c
  *     Nedbaev , SSH
  *  version 1
  *  date    20.2020
  *  ADC верс2 модификация 2
  *  работа с 1 или 2-я каналами с фоновым переключением каналов
  ******************************************************************************
   */
    
#include "IM_ADC2v2-2.h"
#include "stm8s_adc2.h"
#include "string.h"
//#include "IM_tim4.h"
#include "IM_intr_spec.h"


//#if  ((IM_ADC_reg == 0)!! (IM_ADC_reg >= 2 )))
//#endif


#if   (IM_ADC_reg == 0)  
#define IM_ADC2_CH0_IZ 1       // есть 0 ch
#define IM_ADC2_CH1_IZ 0       // нет 1 ch
#endif
#if (IM_ADC_reg==1) 
#define IM_ADC2_CH1_IZ 1       // есть 1 ch
#define IM_ADC2_CH0_IZ 0       // нет 1 ch
#endif

#if  (IM_ADC_reg >= 2 ) 
#define IM_ADC2_CH0_IZ 1 // есть 0 ch
#define IM_ADC2_CH1_IZ 1 // есть 1 ch
#endif


// результаты измерений АЦП [0]-для канала 0, [1] - для канала 1

IM_ADC_R IM_ADCr[2];


// внутренняя структуа
 struct {
 u8 zr;     // заданный режим в IM_ADC_reg 0,1,2,3
 ADC2_PresSel_TypeDef prsc;    // заданная скорость преобразования АЦП  
 u8 pr1 ; // признак =0 - каналы не переключаются 
 u8 pr2 ; // 1 переключать после каждого измерения, 0- после набора суммы для среднего
 u8 CnAI; // 0,1 - тек ном канала для прерываний 

 u16         ns0, ns1; // заданное число усреднений по каналами
 float      fns0,fns1; // =1/ns
 
 u32      aI0,  aI1; // текущая сумма показаний АЦП для усреднения внутри прерывания
 u16    cntI0,cntI1; //  текущий счетчик измерений , внутри прерывания
 
 u32      a0 ,  a1;  // набранная сумма показаний АЦП для усреднения 
 u16    cnt0 ,cnt1;  //  реальный счетчик измерений  
 u8       fL0, fL1;    // признак - =1 сумма набралась, 


 u16 tmpI; // чтение АЦП в прерываниях
 
  
u32 cntI;        // общий счетчик прерываний-измерений
u32 cnt0_,cnt1_;  // счетчики результатов усредненных измерений
} IM_ADCrab ;   // IM_ADCrab.zr pr1







/////////////////
// 2 - два канала, переключение после усреднения
// 3 - два канала, переключение после каждого измерения АЦП
//  ускорять больше нечего.......

 INTERRUPT_HANDLER(ADC2_IRQHandler, 22)
{
// ///новое преобразование надо запускать вручную      IM_ADCrab.pr1

  //  uint16_t temph;


IM_ADCrab.cntI++;
//IM_ADCrab.tmpI  = ADC2_GetConversionValue();       ///  заменить на ускоренное
//. . . . . . . . .
    *(((char*)&IM_ADCrab.tmpI)+0)      = ADC2->DRH;      // сначала DRH
    *(((char*)&IM_ADCrab.tmpI)+1)      = ADC2->DRL;      // потом DRL


if(1)                /// ?????
{
 if (IM_ADCrab.CnAI==0)            //  0-канал!! 0000000000000000000000000000000000000000000000
 {
  IM_ADCrab.aI0 += IM_ADCrab.tmpI;
  IM_ADCrab.cntI0 ++;
  
  
  if(IM_ADCrab.cntI0 >= IM_ADCrab.ns0) // набрали сумму 
   {
   IM_ADCrab.a0   = IM_ADCrab.aI0;          // ADC
   IM_ADCrab.cnt0 = IM_ADCrab.cntI0;       // счетчик
   IM_ADCrab.fL0 = 1;                     // признак завершения
   IM_ADCrab.aI0 = IM_ADCrab.cntI0=0;    // обнулились для след преобразования
   
#if (IM_ADC_reg==2) // если есть перекл И перекл после усреднения? то перекл в этой точке
                                             //      !!!!!!!!!!!!!!!!!!!!!!!!!!!!! 
    ADC2->CSR &= (uint8_t)(~ADC2_CSR_CH);   //      /* Clear the ADC2 channels */
    ADC2->CSR |= (uint8_t)(1);             // на 1 /* Select the ADC2 channel */
                                          //      !!!!!!!!!!!!!!!!!!!!!!!!!!!!! 
    IM_ADCrab.CnAI=1;
#endif   
   }

#if (IM_ADC_reg==3) // если есть перекл И перекл после каждого измерения, то перекл в этой точке
                                             //      !!!!!!!!!!!!!!!!!!!!!!!!!!!!! 
    ADC2->CSR &= (uint8_t)(~ADC2_CSR_CH);   //      /* Clear the ADC2 channels */
    ADC2->CSR |= (uint8_t)(1);             // на 1 /* Select the ADC2 channel */
                                          //      !!!!!!!!!!!!!!!!!!!!!!!!!!!!! 
    IM_ADCrab.CnAI==1;
#endif      
   
 }
 else                           //  1-канал!! 11111111111111111111111111111111111111111111111111
 {
   IM_ADCrab.aI1 += IM_ADCrab.tmpI;
   IM_ADCrab.cntI1 ++;
  
  
  if(IM_ADCrab.cntI1 >= IM_ADCrab.ns1) // набрали сумму 
   {
   IM_ADCrab.a1   = IM_ADCrab.aI1;        // ADC
   IM_ADCrab.cnt1 = IM_ADCrab.cntI1;      // счетчик
   IM_ADCrab.fL1 = 1;                     // признак завершения
   IM_ADCrab.aI1 = IM_ADCrab.cntI1=0;     // обнулились для след преобразования
   
#if (IM_ADC_reg==2) // если есть перекл И перекл после усреднения? то перекл в этой точке
                                             //      !!!!!!!!!!!!!!!!!!!!!!!!!!!!! 
    ADC2->CSR &= (uint8_t)(~ADC2_CSR_CH);   //      /* Clear the ADC2 channels */
    ADC2->CSR |= (uint8_t)(0);             // на 0 /* Select the ADC2 channel */
                                          //      !!!!!!!!!!!!!!!!!!!!!!!!!!!!! 
    IM_ADCrab.CnAI=0;
#endif   
   }

#if (IM_ADC_reg==3) // если есть перекл И перекл после каждого измерения, то перекл в этой точке
                                             //      !!!!!!!!!!!!!!!!!!!!!!!!!!!!! 
    ADC2->CSR &= (uint8_t)(~ADC2_CSR_CH);   //      /* Clear the ADC2 channels */
    ADC2->CSR |= (uint8_t)(0);             // на 0 /* Select the ADC2 channel */
                                          //      !!!!!!!!!!!!!!!!!!!!!!!!!!!!! 
    IM_ADCrab.CnAI=0;
#endif 
 
 
 
 }
} // if ????? 
        
        //  ускорить !!!!!!!
        // сброс прерывания  =  ADC2_ClearITPendingBit(); 
        // ADC2_ClearITPendingBit(); 
				 ADC2->CSR &= (uint8_t)(~ADC2_CSR_EOC);    //BRES  0x5400,#7   !!!!!    
         
 /// запуск след  преобразования  = 
        //  ADC2_StartConversion();
          ADC2->CR1 |= ADC2_CR1_ADON;  //BSET  0x5401,#0 !!!!!
}
//////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////
// функция для конфигурирования АЦП2
void IM_ADC_Config(u16 Lsr0,   //количество усреднений по 0 каналу, если 0 - то 1
                   u16 Lsr1,   //количество усреднений по 1 каналу, если 0 - то 1
                   u8  prsc    // Prescaler работы АСП <=7, если больше, то =7 
                   )
{
ADC2_Channel_TypeDef Ch;

  ADC2_DeInit();

//IM_ADCr  IM_ADCrab - обнулить
  memset(&IM_ADCr,0,sizeof(IM_ADCr));
  memset(&IM_ADCrab,0,sizeof(IM_ADCrab));

if (Lsr0==0)Lsr0=1;
if (Lsr1==0)Lsr1=1;
if (Lsr0>2000)Lsr0=2000;
if (Lsr1>2000)Lsr1=2000;

IM_ADCrab.ns0=Lsr0, 
IM_ADCrab.ns1=Lsr1;
// float      fns0,fns1; // =1/ns
IM_ADCrab.fns0 = 1./Lsr0;
IM_ADCrab.fns1 = 1./Lsr1;

  if (prsc >= 7) prsc=7;
  
  prsc =(u8) (prsc<<((u8)4));    // такой формат ADC2_PresSel_TypeDef
  IM_ADCrab.prsc = (ADC2_PresSel_TypeDef)prsc;  // для параметра ADC2_Init
   
  IM_ADCrab.zr = IM_ADC_reg; //  из дефайна

  
#if (IM_ADC_reg == 0) // канал 0
    GPIO_Init(GPIOB, (GPIO_Pin_TypeDef)GPIO_PIN_0, GPIO_MODE_IN_FL_NO_IT);
    IM_ADCrab.CnAI=0;
    Ch = ADC2_CHANNEL_0;
    IM_ADCrab.pr1 = 0; // каналы не переключать
#endif    
#if (IM_ADC_reg == 1) // канал 1
    GPIO_Init(GPIOB, (GPIO_Pin_TypeDef)GPIO_PIN_1, GPIO_MODE_IN_FL_NO_IT);
    IM_ADCrab.CnAI=1;
    Ch = ADC2_CHANNEL_1;
    IM_ADCrab.pr1 = 0; // каналы не переключать
#endif   
#if (IM_ADC_reg == 2) // канал 0,1  после набора среднего
    GPIO_Init(GPIOB, (GPIO_Pin_TypeDef)GPIO_PIN_0, GPIO_MODE_IN_FL_NO_IT);    // 0 канал ножка
    GPIO_Init(GPIOB, (GPIO_Pin_TypeDef)GPIO_PIN_1, GPIO_MODE_IN_FL_NO_IT);    // 1 канал ножка
    IM_ADCrab.CnAI=0;      // начнем с 0
     Ch = ADC2_CHANNEL_0;  // начнем с 0
    IM_ADCrab.pr1 = 1;     // каналы   переключать
    IM_ADCrab.pr2 = 0;     // перекл после набора среднего
    
#endif  
#if (IM_ADC_reg == 3) // канал 0,1  после каждого измерения
    GPIO_Init(GPIOB, (GPIO_Pin_TypeDef)GPIO_PIN_0, GPIO_MODE_IN_FL_NO_IT);    // 0 канал ножка
    GPIO_Init(GPIOB, (GPIO_Pin_TypeDef)GPIO_PIN_1, GPIO_MODE_IN_FL_NO_IT);    // 1 канал ножка
    IM_ADCrab.CnAI=0;      // начнем с 0
    Ch = ADC2_CHANNEL_0;  // начнем с 0
    IM_ADCrab.pr1 = 1;     // каналы   переключать
    IM_ADCrab.pr2 = 1;     // перекл после каждого
    
#endif    
  
   
  
	ADC2_Init( ADC2_CONVERSIONMODE_SINGLE , // каждое преобр - вручную
	           Ch,                          // номер канала - задаем
	           //ADC2_PRESSEL_FCPU_D2,        // скорость преобразования - задаем
	           (ADC2_PresSel_TypeDef)IM_ADCrab.prsc, 
	           ADC2_EXTTRIG_TIM, DISABLE,   // откл
	           ADC2_ALIGN_RIGHT,            // всегда прижато вправо!
	           ADC2_SCHMITTTRIG_CHANNEL1,DISABLE);   // откл
				 
	
  ADC2_ITConfig(ENABLE);    // прерывания разрешены
  ADC2_Cmd(ENABLE);         // АЦП разрешено
  ADC2_StartConversion(); 	// старт преобразования
	
}


/*  u8    fA;   // =1 - измерений результат обновился
   float A;  // результат измерения после усреднения
   /// диагностика
   u8 FN;          // =1 результат дигностики обновился
   u16 N,Ns;     //  счетчик результато
*/
   
void IM_ADC_handler(void)
{
////////////////////////////////////////////

u32      aa  ; 

if(IM_ADCrab.fL0==1)   // ch0 - 
{
                // запрет прерывания 
   aa = IM_ADCrab.a0;
   IM_ADCrab.fL0 = 0;
         // разрешение прерываний
   IM_ADCr[0].fA = 1;   // флаг результата
   IM_ADCr[0].A  = aa* IM_ADCrab.fns0  ;  // усреднение
   IM_ADCr[0].N++;              // счетчик результатов по каналу
}
if(IM_ADCrab.fL1==1)   // ch1
{
                // запрет прерывания 
   aa = IM_ADCrab.a1;
   IM_ADCrab.fL1 = 0;
         // разрешение прерываний
   IM_ADCr[1].fA = 1;
   IM_ADCr[1].A  = aa* IM_ADCrab.fns1  ;
   IM_ADCr[1].N++;
}
//    в единицу времени - добавить


}
/////////////////////
/////////////////////////////////////////////////////////////////////////
////       для тестирования юез прерывания
void IM_ADC_Config_t(void) 
									
{

  ADC2_DeInit();
    GPIO_Init(GPIOB, (GPIO_Pin_TypeDef)GPIO_PIN_0, GPIO_MODE_IN_FL_NO_IT);
    GPIO_Init(GPIOB, (GPIO_Pin_TypeDef)GPIO_PIN_1, GPIO_MODE_IN_FL_NO_IT);
  
   
  
	ADC2_Init( ADC2_CONVERSIONMODE_SINGLE , // каждое преобр - вручную
	           ADC2_CHANNEL_1,    // номер канала - меняем ЗДЕСЬ!!!
	           ADC2_PRESSEL_FCPU_D2, // скорость преобразования - меняем ЗДЕСЬ
	            
	           ADC2_EXTTRIG_TIM, DISABLE,   // откл
	           ADC2_ALIGN_RIGHT,            // всегда прижато вправо!
	           ADC2_SCHMITTTRIG_CHANNEL1,DISABLE);   // откл
	
  ADC2_Cmd(ENABLE); // АЦП активно
  //ADC2_StartConversion(); 	
	
}

/*

typedef enum {
  ADC2_PRESSEL_FCPU_D2  = (uint8_t)0x00, // **< Prescaler selection fADC2 = fcpu/2  
  ADC2_PRESSEL_FCPU_D3  = (uint8_t)0x10, // **< Prescaler selection fADC2 = fcpu/3  
  ADC2_PRESSEL_FCPU_D4  = (uint8_t)0x20, //**< Prescaler selection fADC2 = fcpu/4  
  ADC2_PRESSEL_FCPU_D6  = (uint8_t)0x30, //**< Prescaler selection fADC2 = fcpu/6  
  ADC2_PRESSEL_FCPU_D8  = (uint8_t)0x40, //**< Prescaler selection fADC2 = fcpu/8  
  ADC2_PRESSEL_FCPU_D10 = (uint8_t)0x50, //**< Prescaler selection fADC2 = fcpu/10  
  ADC2_PRESSEL_FCPU_D12 = (uint8_t)0x60, //**< Prescaler selection fADC2 = fcpu/12  
  ADC2_PRESSEL_FCPU_D18 = (uint8_t)0x70  //**< Prescaler selection fADC2 = fcpu/18  
} ADC2_PresSel_TypeDef;



void ADC2_StartConversion(void);
uint16_t ADC2_GetConversionValue(void);
FlagStatus ADC2_GetFlagStatus(void);
void ADC2_ClearFlag(void);
ITStatus ADC2_GetITStatus(void);
void ADC2_ClearITPendingBit(void);      void IM_ADC_Config_t(void) u16 IM_ADC_get_t(void)
*/

// для тестов - получить одно преобразование 

u16 TI___t1,TI___t;

u16 IM_ADC_get_t(void)  
{
	volatile u16 t,t1,c=0;
	ADC2_ClearFlag( );    
	ADC2_StartConversion( );
	
	// завершилось ли преобразование??
	while( ADC2_GetFlagStatus( ) == RESET )
	 {c++;
	 }  
	 // для отладки - проверка
	   t= ADC2_GetConversionValue( );
    *(((char*)&t1)+0)      = ADC2->DRH;      // сначала DRH
    *(((char*)&t1)+1)      = ADC2->DRL;      // потом DRL
    TI___t1 = t1;
		TI___t  = t;
	 ADC2_ClearFlag( );
   return t;
}	

