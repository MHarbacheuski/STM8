/**
  ******************************************************************************
  *     IM_ADC2v2-4a-1c.c
  *     Nedbaev , SSH
  *  version 1
  *  date    11.2020
  *  ADC верс2 модификация 4 rel=04
  *  *  работа строго с 1 каналом АЦП 
  ******************************************************************************
   */
    
#include "IM_ADC2v2-4a.h"
#include "stm8s_adc2.h"
#include "string.h"
//#include "IM_tim4.h"
#include "IM_intr_spec.h"




// результаты измерений АЦП [0]-для канала 0, [1] - для канала 1

IM_ADC_R IM_ADCr[4];

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
 struct {

 u8     CnAI;     // 0,1,2,3 - тек логический ном канала для прерываний 
 u8     NCn[4];   // массив физических номеров каналов
 u8     NLCn[4];  // цепочка переключений NLCn[x] = ЛогНомСледКанала 
 
 u16     ns[4];   // заданное число усреднений по каналами
 float  fns[4];   // =1/ns
 
 u32      aI; // текущая сумма показаний АЦП для усреднения внутри прерывания
 u16    cntI; //  текущий счетчик измерений , внутри прерывания
 
 u32       a[4];  // набранная сумма показаний АЦП для усреднения 
 u16     cnt[4];  //  реальный счетчик измерений  
 u8       fL[4];    // признак - =1 сумма набралась, 
 u32    cnt_[4];  // счетчики результатов усредненных измерений

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

//IM_ADCrab.tmpI  = ADC2_GetConversionValue();       ///  заменить на ускоренное
// считали результат 
 /* Right alignment */
 //   
 //       /* Read LSB first */
 //       templ = ADC2->DRL;
 //       /* Then read MSB */
 //       temph = ADC2->DRH;


*(((char*)&IM_ADCrab.tmpI)+1)      = ADC2->DRL;      // сначала  DRL
*(((char*)&IM_ADCrab.tmpI)+0)      = ADC2->DRH;      // потом DRH
 


// if (IM_ADCrab.CnAI==0)            //  0-канал!! 0000000000000000000000000000000000000000000000
 {
  IM_ADCrab.aI += IM_ADCrab.tmpI;
  
     if(IM_ADCrab.cntI >= IM_ADCrab.ns[0]) // набрали сумму 
   
	   {
       IM_ADCrab.a[0]   = IM_ADCrab.aI;          // ADC
       IM_ADCrab.cnt[0] = IM_ADCrab.cntI;       // счетчик
       IM_ADCrab.fL[0] = 1;                     // признак завершения
       IM_ADCrab.aI = IM_ADCrab.cntI=0;    // обнулились для след преобразования
       
/*
       //  перекл после усреднения
       // следующий  канал                   // !!!!!!!!!!!!!!!!!!!!!!!!!!!!! 
       IM_ADCrab.CnAI= IM_ADCrab.NLCn[1];    // след логический канал IM_ADCrab.NLCn[]
			 ADC2->CSR &= (uint8_t)(~ADC2_CSR_CH); //  Clear the ADC2 channels 
			 // след физ канал  
       ADC2->CSR |= (uint8_t)(IM_ADCrab.NCn[1]); //Select the ADC2 channel
*/			                                      
       
			 }   
   
 }

# if 0
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
       IM_ADCrab.CnAI= IM_ADCrab.NLCn[2];    // след логический канал IM_ADCrab.NLCn[]
			 ADC2->CSR &= (uint8_t)(~ADC2_CSR_CH); //  Clear the ADC2 channels 
			 /* след физ канал  */
       ADC2->CSR |= (uint8_t)(IM_ADCrab.NCn[2]); //Select the ADC2 channel
			 }   
   
 }
 else
  if (IM_ADCrab.CnAI==2)            //  2-канал!! 0000000000000000000000000000000000000000000000
 {
  IM_ADCrab.aI += IM_ADCrab.tmpI;
  
     if(IM_ADCrab.cntI >= IM_ADCrab.ns[1]) // набрали сумму 
   
	   {
       IM_ADCrab.a[2]   = IM_ADCrab.aI;          // ADC
       IM_ADCrab.cnt[2] = IM_ADCrab.cntI;       // счетчик
       IM_ADCrab.fL[2] = 1;                     // признак завершения
       IM_ADCrab.aI = IM_ADCrab.cntI=0;    // обнулились для след преобразования
       
			 //  перекл после усреднения
       // следующий  канал                   // !!!!!!!!!!!!!!!!!!!!!!!!!!!!! 
       IM_ADCrab.CnAI= IM_ADCrab.NLCn[3];    // след логический канал IM_ADCrab.NLCn[]
			 ADC2->CSR &= (uint8_t)(~ADC2_CSR_CH); //  Clear the ADC2 channels 
			 /* след физ канал  */
       ADC2->CSR |= (uint8_t)(IM_ADCrab.NCn[3]); //Select the ADC2 channel
			 }   
   
 }
 else
  if (IM_ADCrab.CnAI==3)            //  3-канал!! 0000000000000000000000000000000000000000000000
 {
  IM_ADCrab.aI += IM_ADCrab.tmpI;
  
     if(IM_ADCrab.cntI >= IM_ADCrab.ns[3]) // набрали сумму 
   
	   {
       IM_ADCrab.a[3]   = IM_ADCrab.aI;          // ADC
       IM_ADCrab.cnt[3] = IM_ADCrab.cntI;       // счетчик
       IM_ADCrab.fL[3] = 1;                     // признак завершения
       IM_ADCrab.aI = IM_ADCrab.cntI=0;    // обнулились для след преобразования
       
			 //  перекл после усреднения
       // следующий  канал                   // !!!!!!!!!!!!!!!!!!!!!!!!!!!!! 
       IM_ADCrab.CnAI= IM_ADCrab.NLCn[0];    // след логический канал IM_ADCrab.NLCn[]
			 ADC2->CSR &= (uint8_t)(~ADC2_CSR_CH); //  Clear the ADC2 channels 
			 /* след физ канал  */
       ADC2->CSR |= (uint8_t)(IM_ADCrab.NCn[0]); //Select the ADC2 channel
			 }   
   
 }
#endif
 
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
// ноги и каналы - вручную

void IM_ADC_Config(u16 Lsr0,   //количество усреднений по 0 каналу, если 0 - то 1
                   u16 Lsr1,   //количество усреднений по 1 каналу, если 0 - то 1
                   u16 Lsr2,   //количество усреднений по 2 каналу, если 0 - то 1
                   u16 Lsr3,   //количество усреднений по 3 каналу, если 0 - то 1
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
if (Lsr2==0)Lsr2=1;
if (Lsr3==0)Lsr3=1;

if (Lsr0>2000)Lsr0=2000;
if (Lsr1>2000)Lsr1=2000;
if (Lsr2>2000)Lsr2=2000;
if (Lsr3>2000)Lsr3=2000;

IM_ADCrab.ns[0]=Lsr0;
IM_ADCrab.ns[1]=Lsr1;
IM_ADCrab.ns[2]=Lsr2;
IM_ADCrab.ns[3]=Lsr3;

// float      fns0,fns1; // =1/ns
IM_ADCrab.fns[0] = 1./Lsr0;
IM_ADCrab.fns[1] = 1./Lsr1;
IM_ADCrab.fns[2] = 1./Lsr2;
IM_ADCrab.fns[3] = 1./Lsr3;

  if (prsc >= 7) prsc=7;
  prsc =(u8) (prsc<<((u8)4));    // такой формат ADC2_PresSel_TypeDef
   
  //IM_ADCrab.zr = IM_ADC_reg; //  из дефайна

  //////////////////////////////////////////
	///настроить вручную - за/рас комментарить !!!!
	GPIO_Init(GPIOB, (GPIO_Pin_TypeDef)GPIO_PIN_0, GPIO_MODE_IN_FL_NO_IT);
	//GPIO_Init(GPIOB, (GPIO_Pin_TypeDef)GPIO_PIN_1, GPIO_MODE_IN_FL_NO_IT);
	//GPIO_Init(GPIOB, (GPIO_Pin_TypeDef)GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);
	//GPIO_Init(GPIOB, (GPIO_Pin_TypeDef)GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);
	//GPIO_Init(GPIOB, (GPIO_Pin_TypeDef)GPIO_PIN_4, GPIO_MODE_IN_FL_NO_IT);
  //GPIO_Init(GPIOB, (GPIO_Pin_TypeDef)GPIO_PIN_5, GPIO_MODE_IN_FL_NO_IT);
	//GPIO_Init(GPIOB, (GPIO_Pin_TypeDef)GPIO_PIN_6, GPIO_MODE_IN_FL_NO_IT);
	//GPIO_Init(GPIOB, (GPIO_Pin_TypeDef)GPIO_PIN_7, GPIO_MODE_IN_FL_NO_IT);
	
  // в соответсвии с настроенными ногами !!!!!
  // логический канал = физический канал АЦП =
  //                    номер пина порт Вх GPIO_PIN_х
     IM_ADCrab.NCn[0] =   0;
     IM_ADCrab.NCn[1] =   3;
     IM_ADCrab.NCn[2] =   4;
     IM_ADCrab.NCn[3] =   5;
	// u8     NLCn[4];
	// перемудрил !!! проверить !!!
	   IM_ADCrab.NLCn[0] = 0; // после работы с нулевым каналов в прерываниях
		                        // надо перекл на "1" лог канал!!
		 IM_ADCrab.NLCn[1] = 1;
		 IM_ADCrab.NLCn[2] = 2;
		 IM_ADCrab.NLCn[3] = 3; // замкнули на 0 канал
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


/*  u8    fA;   // =1 - измерений результат обновился
   float A;  // результат измерения после усреднения
   /// диагностика
   u8 FN;          // =1 результат дигностики обновился
   u16 N,Ns;     //  счетчик результато
*/


////////////////////////////////////////////////////////////////////
// 1- был хотя бы 1 результат в IM_ADCr
// искать по флагу IM_ADCr[i].fA = 1; 
u8 IM_ADC_handler(void)
{
////////////////////////////////////////////

u32      aa  ; 
u8 i,ii=0;
for(i=0;i<4;i++)
{
   if(IM_ADCrab.fL[i]==1)   // ch0 - 
    {
                // запрет прерывания 
   aa = IM_ADCrab.a[i];
   IM_ADCrab.fL[i] = 0;

// разрешение прерываний
	 IM_ADCrab.cnt_[i]++;

   IM_ADCr[i].fA = 1;   // флаг результата
   IM_ADCr[i].A  = aa* IM_ADCrab.fns[i]  ;  // усреднение
	 IM_ADCr[i].IA = (u16)(IM_ADCr[i].A*10.+0.5);
   IM_ADCr[i].N++;              // счетчик результатов по каналу
	 ii=1;
     }

//    в единицу времени - добавить

} // for
return ii ;  // 1- был хотя бы 1 результат
}

#if 0
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
//	     if ((ADC2->CR2 & ADC2_CR2_ALIGN) != 0) /* Right alignment */
//    {
//        /* Read LSB first */
//        templ = ADC2->DRL;
//        /* Then read MSB */
//        temph = ADC2->DRH;
//      temph = (uint16_t)(templ | (uint16_t)(temph << (uint8_t)8));
//    }
	   t= ADC2_GetConversionValue( );
    *(((char*)&t1)+1)      = ADC2->DRL;      // потом DRL
    *(((char*)&t1)+0)      = ADC2->DRH;      // сначала DRH

    TI___t1 = t1;
    TI___t  = t;
	 ADC2_ClearFlag( );
   return t;
}	

#endif