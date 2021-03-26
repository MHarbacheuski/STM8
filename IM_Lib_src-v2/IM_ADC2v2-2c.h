/**
  *****************************************************************************
  *  IM_ADC2v2_2c.h
  *  Gorbachevskiy
  *  version 1
  *  date    24.01.2021
  *  ADC ����2 ����������� 2 rel=02 
  *  ������ � 2-� �������� ����� � ������� ������������� �������
  *
  ******************************************************************************
   */

#ifndef __IM_ADC2v2_2c                               
#define __IM_ADC2v2_2c
#include "stm8s.h"




// ������������� ���
void IM_ADC_Config(u16 Lsr0,   //���������� ���������� �� 0 ������, ���� 0 - �� 1
                   u16 Lsr1,   //���������� ���������� �� 1 ������, ���� 0 - �� 1
                   u8 ch0,   //��� ����� 0-�� ����������� ������ (0-7)
                   u8 ch1,   //��� ����� 0-�� ����������� ������ (0-7)
                   u8  prsc   // Prescaler ������ ��� <=7, ���� ������, �� =7 
                              // =0 < Prescaler selection fADC2 = fcpu/2   
                              // =1 < Prescaler selection fADC2 = fcpu/3   
                              // =2 < Prescaler selection fADC2 = fcpu/4   
                              // =3 < Prescaler selection fADC2 = fcpu/6   
                              // =4 < Prescaler selection fADC2 = fcpu/8   
                              // =5 < Prescaler selection fADC2 = fcpu/10  
                              // =6 < Prescaler selection fADC2 = fcpu/12  
                              // =7 < Prescaler selection fADC2 = fcpu/18  
                   );

u8 IM_ADC_handler(void);// 1- ��� ���� �� 1 ���������

///////////////////////////////////////////////////////////////////////////////////////
// ���������� ��������� ��� [0]-��� ������ 0, [1] - ��� ������ 1
typedef
struct 
{
   
   u8    fA;   // =1 - ��������� ��������� ���������
   float A;  // ��������� ��������� ����� ����������
	 u16   IA; // *10
   /// �����������
   u8 FN;          // =1 ��������� ���������� ���������
   u16 N,Ns;     //  ������� ����������� ����� � �� �������( ����������� ���� ��� � �������)         
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

