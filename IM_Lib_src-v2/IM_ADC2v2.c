/**
  ******************************************************************************
  * @file    can.c
  * @author  Nedbaev
  * @version 1
  * @date    11.2019
  * @brief   ADC functions
  ******************************************************************************
   */
    
#include "IM_ADC2v2.h"
//#include "stm8s_adc2.h"
#include "string.h"
#include "IM_tim4.h"
#include "IM_intr_spec.h"

#define Nmeasures 16   // число измерений для фильтрации
u16 srednee(u16 *a,u16 n); // функция для получения среднего 
                     // bp 16 pyfxtybq 
u16 mediana16_16(u16 *a); // фильтр медиана по 16 значениям 

uint16_t bufadc0[Nmeasures];
uint16_t bufadc1[Nmeasures];
u8  ADC_1_2;  
										 
u16 bufadc2v_R0[Nmeasures],bufadc2v_R1[Nmeasures]; 
u16 vallsr[16];   //  массив результирующих значений

u8 filtr_adc;

//  bufadc2v_R -  real value , значения после обработки
u8 flagEOC1;	
u16 tmpbuf;

 INTERRUPT_HANDLER(ADC2_IRQHandler, 22)
{
			tmpbuf  = ADC2_GetConversionValue();

      if(ADC_1_2 == 0) 
			         bufadc0[iadc]  = tmpbuf;
      else		 bufadc1[iadc]  = tmpbuf;			

			if(iadc == 0)
			    flagEOC1 = 1;
					 						
			ADC2_ClearITPendingBit();
}


u16 valsrsr0,valsrsr1;

u16 iadc;
u32 iadcssk; //  общее количество проведённых  измерений

volatile u16 iadcs;
u8 time_opros_adc;
u16 IMADCv0,IMADCv1;


// функция для конфигурирования АЦП2
void IM_ADC_Config(void)
{
	GPIO_Init(GPIOB, (GPIO_Pin_TypeDef)GPIO_PIN_1, GPIO_MODE_IN_FL_NO_IT);
//GPIO_MODE_IN_PU_NO_IT

	ADC2_DeInit();

	ADC2_Init( ADC2_CONVERSIONMODE_SINGLE ,ADC2_CHANNEL_1,ADC2_PRESSEL_FCPU_D2,
	            ADC2_EXTTRIG_TIM,DISABLE, ADC2_ALIGN_RIGHT, 
              ADC2_SCHMITTTRIG_CHANNEL1, DISABLE);
				 
	
	memset(bufadc2v_R0,0,sizeof(bufadc2v_R0));
	memset(bufadc2v_R1,0,sizeof(bufadc2v_R1));
	memset(vallsr,0,sizeof(vallsr));
	iadc = 0; iadcs = 0;  
	
  flagEOC1 = 0;
	
	time_opros_adc = 4;
	iadcssk = 0;
	time_adc = 0;
	filtr_adc = 3;
	
  ADC2_ITConfig(ENABLE);
  ADC2_Cmd(ENABLE);
  ADC2_StartConversion(); 	
	
}

void ADC_REConfig1(void)
{
	ADC2_Init( ADC2_CONVERSIONMODE_SINGLE ,ADC2_CHANNEL_1,ADC2_PRESSEL_FCPU_D2,
	            ADC2_EXTTRIG_TIM,DISABLE, ADC2_ALIGN_RIGHT, 
              ADC2_SCHMITTTRIG_CHANNEL5, DISABLE);	
}
void ADC_REConfig0(void)
{
	ADC2_Init( ADC2_CONVERSIONMODE_SINGLE ,ADC2_CHANNEL_0,ADC2_PRESSEL_FCPU_D2,
	            ADC2_EXTTRIG_TIM,DISABLE, ADC2_ALIGN_RIGHT, 
              ADC2_SCHMITTTRIG_CHANNEL4, DISABLE);
}

#if 0
filtr_adc ==
1 - результирующее значение АЦП без обработки
2 - среднее  по Nmeasures
3 - скользящее среднее  по Nmeasures
4 - дополнительное усреднение средних значений по 16
#endif

void IM_ADC_handler(void)
{
		// Если произошлаа какая либо ошиибка и АЦП
		// перестало работать - перезапусстить через 2 сек:
     if(time_adc > 2000)
		 {
         time_adc = 0;
	       IM_ADC_Config();
         ADC2_ITConfig(ENABLE);
         ADC2_Cmd(ENABLE);
         ADC2_StartConversion(); 
	   }				
	
	  
	if(time_adc > (time_opros_adc - 1) )
			if(flagEOC1 == 1)
  {
		u8 j,ii;

	         flagEOC1 = 0; //флаг, что проишло 16 измерений
					 // и данные записаны в bufadc
		       time_adc = 0;
					 
       if(filtr_adc == 3)
			 {
///////////////////  скользящее среднее///////////////////
         if(ADC_1_2 == 0) 
					bufadc0[iadcs] = srednee(bufadc0,Nmeasures);
				 if(ADC_1_2 == 1) 
					bufadc1[iadcs] = srednee(bufadc1,Nmeasures);
		   } 					 

           if(iadc == 0)
           { 					 
  				    bufadc2v_R0[iadcs] = srednee(bufadc0,Nmeasures);
					   //mediana16_16(bufadc);
						  bufadc2v_R1[iadcs] = srednee(bufadc1,Nmeasures);
							
							if(ADC_1_2 == 1) 
							{
							   iadcs ++;
					       if(iadcs > 15)
					           iadcs = 0;							
						  }

						 if( (filtr_adc == 2)||(filtr_adc == 3))
					 {
						  if(ADC_1_2 == 0)
                IMADCv0 = bufadc2v_R0[iadcs];
							if(ADC_1_2 == 1)
								IMADCv1 = bufadc2v_R1[iadcs];
				   }	
					 
if(filtr_adc == 4)
if(iadcs == 0)
{
	    if(ADC_1_2 == 0) 
				 valsrsr0 = 
				           //mediana16_16(bufadc2v_R);	
				            srednee(bufadc2v_R0,16);	// результирующее
										// среднее значение
			if(ADC_1_2 == 1) 
				 valsrsr1 = 
				           //mediana16_16(bufadc2v_R);	
				            srednee(bufadc2v_R1,16);	// результирующее
										// среднее значение										

		 
}					 
        }
/////////////////////////////////////////////////////////////

     if(filtr_adc == 1)
		 {
			   if(ADC_1_2 == 0) 
            IMADCv0 = bufadc0[iadc];
				 if(ADC_1_2 == 1) 	
					  IMADCv1 = bufadc1[iadc];
	   }					
 
		// переключиться с первого канала на
    //   второй 

      if(ADC_1_2 == 1) 
			{
				if(iadc < (Nmeasures-1)) 
		                 iadc ++;
        else         iadc = 0; 
				
				iadcssk ++;
		  }


    ADC_1_2 ^= 1;
		if(ADC_1_2 == 0)
		       ADC_REConfig0();
    else	 ADC_REConfig1();		


    ADC2_StartConversion();
		
  }

 }


u16 srednee(u16 *a,u16 n)
{ u8 i;
  u32 res;
	float ff1;
  
  res = 0;
  for(i=0;i<n;i++)
  {
    res += *(a+i);
  }
	ff1 = (float)res/(float)n;
  res = (u16)ff1;
	
	ff1 = ff1 - (float)res;
	ff1 = 100.*ff1;
	i = (u8)ff1;
	if(i > 50.)
	      res += 1;
  return (u16)res;
}

u16  aa[16],aa1[16],a7,a8,ind,ii,ii1,ares,tmp;
	
u16 mediana16_16(u16 *a)
{

u16 *b;
u16 res,aaa;

  aaa = 0; 
	ind = 0;
	ii1 = 0;
	for(ii1 = 0; ii1 < 8; ii1 ++)
	{
	aaa = 0;	
	for(b=a,ii = 0; ii < 16; ii ++,b++)
	{
		if(aaa <  *b)
	   {
       aaa = *b;
			 ind = ii;
	   }
  }
  *(a+ind) = 0;
 }
 return aaa;
}


