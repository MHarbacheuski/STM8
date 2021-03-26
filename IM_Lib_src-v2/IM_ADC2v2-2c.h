/**
  *****************************************************************************
  *  IM_ADC2v2_2c.h
  *  Gorbachevskiy
  *  version 1
  *  date    24.01.2021
  *  ADC верс2 модификация 2 rel=02 
  *  работа с 2-я каналами ровно с фоновым переключением каналов
  *
  ******************************************************************************
   */

#ifndef __IM_ADC2v2_2c                               
#define __IM_ADC2v2_2c
#include "stm8s.h"




// инициализация АЦП
void IM_ADC_Config(u16 Lsr0,   //количество усреднений по 0 каналу, если 0 - то 1
                   u16 Lsr1,   //количество усреднений по 1 каналу, если 0 - то 1
                   u8 ch0,   //физ канал 0-го логического канала (0-7)
                   u8 ch1,   //физ канал 0-го логического канала (0-7)
                   u8  prsc   // Prescaler работы АЦП <=7, если больше, то =7 
                              // =0 < Prescaler selection fADC2 = fcpu/2   
                              // =1 < Prescaler selection fADC2 = fcpu/3   
                              // =2 < Prescaler selection fADC2 = fcpu/4   
                              // =3 < Prescaler selection fADC2 = fcpu/6   
                              // =4 < Prescaler selection fADC2 = fcpu/8   
                              // =5 < Prescaler selection fADC2 = fcpu/10  
                              // =6 < Prescaler selection fADC2 = fcpu/12  
                              // =7 < Prescaler selection fADC2 = fcpu/18  
                   );

u8 IM_ADC_handler(void);// 1- был хотя бы 1 результат

///////////////////////////////////////////////////////////////////////////////////////
// результаты измерений АЦП [0]-для канала 0, [1] - для канала 1
typedef
struct 
{
   
   u8    fA;   // =1 - измерений результат обновился
   float A;  // результат измерения после усреднения
	 u16   IA; // *10
   /// диагностика
   u8 FN;          // =1 результат дигностики обновился
   u16 N,Ns;     //  счетчик результатов всего и за секунду( Обновляется один раз в секунду)         
 } IM_ADC_R; 

extern IM_ADC_R IM_ADCr[2];    


//////////////////
void IM_ADC_Config_t(void);
u16 IM_ADC_get_t(void);




#endif // __IM_ADC2v2_2








#if 0
typedef enum {
  ADC2_PRESSEL_FCPU_D2  = (uint8_t)0x00, /**< Prescaler selection fADC2 = fcpu/2 */
  ADC2_PRESSEL_FCPU_D3  = (uint8_t)0x10, /**< Prescaler selection fADC2 = fcpu/3 */
  ADC2_PRESSEL_FCPU_D4  = (uint8_t)0x20, /**< Prescaler selection fADC2 = fcpu/4 */
  ADC2_PRESSEL_FCPU_D6  = (uint8_t)0x30, /**< Prescaler selection fADC2 = fcpu/6 */
  ADC2_PRESSEL_FCPU_D8  = (uint8_t)0x40, /**< Prescaler selection fADC2 = fcpu/8 */
  ADC2_PRESSEL_FCPU_D10 = (uint8_t)0x50, /**< Prescaler selection fADC2 = fcpu/10 */
  ADC2_PRESSEL_FCPU_D12 = (uint8_t)0x60, /**< Prescaler selection fADC2 = fcpu/12 */
  ADC2_PRESSEL_FCPU_D18 = (uint8_t)0x70  /**< Prescaler selection fADC2 = fcpu/18 */
} ADC2_PresSel_TypeDef;
//////////


#endif

