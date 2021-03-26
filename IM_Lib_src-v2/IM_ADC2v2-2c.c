/**
  ******************************************************************************
  *  IM_ADC2v2-2�.c
  *  Gorbachevskiy
  *  version 1
  *  date    24.01.2021
  *  ADC ����2 ����������� 2 rel=02
  *  *  ������ � 2-� �������� ����� � ������� ������������� �������
  ******************************************************************************
   */
    
#include "IM_ADC2v2-2c.h"
#include "stm8s_adc2.h"
#include "string.h"
//#include "IM_tim4.h"
#include "IM_intr_spec.h"




// ���������� ��������� ��� [0]-��� ������ 0, [1] - ��� ������ 1

IM_ADC_R IM_ADCr[2];//������ �������� 

#if 0
struct //������� ���������
{
   u8    fA;   // =1 - ��������� ��������� ���������
   float A;  // ��������� ��������� ����� ����������
	 u16   IA; // *10
   /// �����������
   u8 FN;          // =1 ��������� ���������� ���������
   u16 N,Ns;     //  ������� ����������� ����� � �� �������( ����������� ���� ��� � �������)         
} IM_ADC_R; 
#endif

// ���������� ��������
 struct 
{
 u8     CnAI;     // 0,1 - ��� ���������� ��� ������ ��� ���������� 
 u8     NCn[2];   // ������ ���������� ������� �������
 u8     NLCn[2];  // ������� ������������ NLCn[x] = ���������������� 
 
 u16     ns[2];   // �������� ����� ���������� �� ��������
 float  fns[2];   // =1/ns
 
 u32      aI; // ������� ����� ��������� ��� ��� ���������� ������ ����������
 u16    cntI; //  ������� ������� ��������� , ������ ����������
 
 u32       a[2];  // ��������� ����� ��������� ��� ��� ���������� 
 u16     cnt[2];  //  �������� ������� ���������  
 u8       fL[2];    // ������� - =1 ����� ���������, 
 u32    cnt_[2];  // �������� ����������� ����������� ���������

 u16 tmpI; // ������ ��� � �����������
 u32 cntII;        // ����� ������� ����������-���������

} IM_ADCrab ;   // IM_ADCrab.NCn pr1


////////////////////////////////////////////////////////////
//  ����������
 INTERRUPT_HANDLER(ADC2_IRQHandler, 22)
{
// 

IM_ADCrab.cntI++;
IM_ADCrab.cntII++;


*(((char*)&IM_ADCrab.tmpI)+1)      = ADC2->DRL;      // �������  DRL
*(((char*)&IM_ADCrab.tmpI)+0)      = ADC2->DRH;      // ����� DRH
 


 if (IM_ADCrab.CnAI==0)            //  0-�����!! 0000000000000000000000000000000000000000000000
 {
  IM_ADCrab.aI += IM_ADCrab.tmpI;
  
     if(IM_ADCrab.cntI >= IM_ADCrab.ns[0]) // ������� ����� 
   
	   {
       IM_ADCrab.a[0]   = IM_ADCrab.aI;          // ADC
       IM_ADCrab.cnt[0] = IM_ADCrab.cntI;       // �������
       IM_ADCrab.fL[0] = 1;                     // ������� ����������
       IM_ADCrab.aI = IM_ADCrab.cntI=0;    // ���������� ��� ���� ��������������
       
			 //  ������ ����� ����������
       // ���������  �����                   // !!!!!!!!!!!!!!!!!!!!!!!!!!!!! 
       IM_ADCrab.CnAI= IM_ADCrab.NLCn[1];    // ���� ���������� ����� IM_ADCrab.NLCn[]
			 ADC2->CSR &= (uint8_t)(~ADC2_CSR_CH); //  Clear the ADC2 channels 
			 /* ���� ��� �����  */
       ADC2->CSR |= (uint8_t)(IM_ADCrab.NCn[1]); //Select the ADC2 channel
			                                      
       
			 }   
   
 }
 else
  if (IM_ADCrab.CnAI==1)            //  1-�����!! 0000000000000000000000000000000000000000000000
 {
  IM_ADCrab.aI += IM_ADCrab.tmpI;
  
  
     if(IM_ADCrab.cntI >= IM_ADCrab.ns[1]) // ������� ����� 
   
	   {
       IM_ADCrab.a[1]   = IM_ADCrab.aI;          // ADC
       IM_ADCrab.cnt[1] = IM_ADCrab.cntI;       // �������
       IM_ADCrab.fL[1] = 1;                     // ������� ����������
       IM_ADCrab.aI = IM_ADCrab.cntI=0;    // ���������� ��� ���� ��������������
       
			 //  ������ ����� ����������
       // ���������  �����                   // !!!!!!!!!!!!!!!!!!!!!!!!!!!!! 
       IM_ADCrab.CnAI= IM_ADCrab.NLCn[0];    // ���� ���������� ����� IM_ADCrab.NLCn[]
			 ADC2->CSR &= (uint8_t)(~ADC2_CSR_CH); //  Clear the ADC2 channels 
			 /* ���� ��� �����  */
       ADC2->CSR |= (uint8_t)(IM_ADCrab.NCn[0]); //Select the ADC2 channel
			 }   
   
 }
        // ����� ����������  =  ADC2_ClearITPendingBit(); 
        // ADC2_ClearITPendingBit(); 
				 ADC2->CSR &= (uint8_t)(~ADC2_CSR_EOC);//BRES  0x5400,#7   !!!!!    
         
        /// ������ ����  ��������������  = 
        //  ADC2_StartConversion();
          ADC2->CR1 |= ADC2_CR1_ADON;        //BSET  0x5401,#0 !!!!!
}
//////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////
// ������� ��� ���������������� ���2

void IM_ADC_Config(u16 Lsr0,   //���������� ���������� �� 0 ������, ���� 0 - �� 1
                   u16 Lsr1,   //���������� ���������� �� 1 ������, ���� 0 - �� 1
                   u8 ch0, //��� ����� 0-�� ����������� ������ (0-7)
                   u8 ch1,   //��� ����� 0-�� ����������� ������ (0-7)
                   u8  prsc    // Prescaler ������ ��� <=7, ���� ������, �� =7 
                   )
{
ADC2_Channel_TypeDef Ch;

  ADC2_DeInit();//���������������� ������������ �������� ADC2
								//�� �� ������ �������� �� ���������.

//IM_ADCr � IM_ADCrab - ��������
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
  prsc =(u8) (prsc<<((u8)4));    // ����� ������ ADC2_PresSel_TypeDef
   

  //////////////////////////////////////////
	GPIO_Init(GPIOB, (GPIO_Pin_TypeDef)GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);
	GPIO_Init(GPIOB, (GPIO_Pin_TypeDef)GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);
	
  // � ����������� � ������������ ������ !!!!!
  // ���������� ����� = ���������� ����� ��� =
  //                    ����� ���� ���� �� GPIO_PIN_�
     IM_ADCrab.NCn[0] =   ch0;
     IM_ADCrab.NCn[1] =   ch1;

	   IM_ADCrab.NLCn[0] = 0; // ����� ������ � ������� ������� � �����������
		                        // ���� ������ �� "1" ��� �����!!
		 IM_ADCrab.NLCn[1] = 1;
//  
//
//
//

	ADC2_Init( ADC2_CONVERSIONMODE_SINGLE , // ������ ������ ����� ��������� �������
	           IM_ADCrab.NCn[0],   // ����� ������ - ������
	           //ADC2_PRESSEL_FCPU_Dx,        // �������� �������������� - ������
	           (ADC2_PresSel_TypeDef)prsc, 
	           ADC2_EXTTRIG_TIM, DISABLE,   // ������ ����
	           ADC2_ALIGN_RIGHT,            // ������ ������� ������!
	           ADC2_SCHMITTTRIG_CHANNEL1,DISABLE);   //������ ����
				 
	
  ADC2_ITConfig(ENABLE);    // ���������� ���������
  ADC2_Cmd(ENABLE);         // ��� ���������
  ADC2_StartConversion();   // ����� ������� ��������������
	
}



////////////////////////////////////////////////////////////////////
// 1- ��� ���� �� 1 ��������� � IM_ADCr
// ������ �� ����� IM_ADCr[i].fA = 1; 
u8 IM_ADC_handler(void)//������ ������� ������������ ��� ������ � ���
{
////////////////////////////////////////////
  u32  aa; 
  u8 i,ii=0;
  for(i=0;i<2;i++)
  {
    if(IM_ADCrab.fL[i]==1)  
    {
		disableInterrupts();//������ ����������
     aa = IM_ADCrab.a[i];
     IM_ADCrab.fL[i] = 0;
		 
		enableInterrupts();// ���������� ����������
		 IM_ADCrab.cnt_[i]++;

     IM_ADCr[i].fA = 1;   // ���� ����������
     IM_ADCr[i].A  = aa* IM_ADCrab.fns[i]  ;  // ����������
	   IM_ADCr[i].IA = (u16)(IM_ADCr[i].A*10.+0.5);
     IM_ADCr[i].N++;              // ������� ����������� �� ������
	   ii=1;
		}

  } // for
 return ii ;  // 1- ��� ���� �� 1 ���������
}