/**
  ******************************************************************************
  *     IM_ADC2v2-4a-1c.c
  *     Nedbaev , SSH
  *  version 1
  *  date    11.2020
  *  ADC ����2 ����������� 4 rel=04
  *  *  ������ ������ � 1 ������� ��� 
  ******************************************************************************
   */
    
#include "IM_ADC2v2-4a.h"
#include "stm8s_adc2.h"
#include "string.h"
//#include "IM_tim4.h"
#include "IM_intr_spec.h"




// ���������� ��������� ��� [0]-��� ������ 0, [1] - ��� ������ 1

IM_ADC_R IM_ADCr[4];

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
 struct {

 u8     CnAI;     // 0,1,2,3 - ��� ���������� ��� ������ ��� ���������� 
 u8     NCn[4];   // ������ ���������� ������� �������
 u8     NLCn[4];  // ������� ������������ NLCn[x] = ���������������� 
 
 u16     ns[4];   // �������� ����� ���������� �� ��������
 float  fns[4];   // =1/ns
 
 u32      aI; // ������� ����� ��������� ��� ��� ���������� ������ ����������
 u16    cntI; //  ������� ������� ��������� , ������ ����������
 
 u32       a[4];  // ��������� ����� ��������� ��� ��� ���������� 
 u16     cnt[4];  //  �������� ������� ���������  
 u8       fL[4];    // ������� - =1 ����� ���������, 
 u32    cnt_[4];  // �������� ����������� ����������� ���������

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

//IM_ADCrab.tmpI  = ADC2_GetConversionValue();       ///  �������� �� ����������
// ������� ��������� 
 /* Right alignment */
 //   
 //       /* Read LSB first */
 //       templ = ADC2->DRL;
 //       /* Then read MSB */
 //       temph = ADC2->DRH;


*(((char*)&IM_ADCrab.tmpI)+1)      = ADC2->DRL;      // �������  DRL
*(((char*)&IM_ADCrab.tmpI)+0)      = ADC2->DRH;      // ����� DRH
 


// if (IM_ADCrab.CnAI==0)            //  0-�����!! 0000000000000000000000000000000000000000000000
 {
  IM_ADCrab.aI += IM_ADCrab.tmpI;
  
     if(IM_ADCrab.cntI >= IM_ADCrab.ns[0]) // ������� ����� 
   
	   {
       IM_ADCrab.a[0]   = IM_ADCrab.aI;          // ADC
       IM_ADCrab.cnt[0] = IM_ADCrab.cntI;       // �������
       IM_ADCrab.fL[0] = 1;                     // ������� ����������
       IM_ADCrab.aI = IM_ADCrab.cntI=0;    // ���������� ��� ���� ��������������
       
/*
       //  ������ ����� ����������
       // ���������  �����                   // !!!!!!!!!!!!!!!!!!!!!!!!!!!!! 
       IM_ADCrab.CnAI= IM_ADCrab.NLCn[1];    // ���� ���������� ����� IM_ADCrab.NLCn[]
			 ADC2->CSR &= (uint8_t)(~ADC2_CSR_CH); //  Clear the ADC2 channels 
			 // ���� ��� �����  
       ADC2->CSR |= (uint8_t)(IM_ADCrab.NCn[1]); //Select the ADC2 channel
*/			                                      
       
			 }   
   
 }

# if 0
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
       IM_ADCrab.CnAI= IM_ADCrab.NLCn[2];    // ���� ���������� ����� IM_ADCrab.NLCn[]
			 ADC2->CSR &= (uint8_t)(~ADC2_CSR_CH); //  Clear the ADC2 channels 
			 /* ���� ��� �����  */
       ADC2->CSR |= (uint8_t)(IM_ADCrab.NCn[2]); //Select the ADC2 channel
			 }   
   
 }
 else
  if (IM_ADCrab.CnAI==2)            //  2-�����!! 0000000000000000000000000000000000000000000000
 {
  IM_ADCrab.aI += IM_ADCrab.tmpI;
  
     if(IM_ADCrab.cntI >= IM_ADCrab.ns[1]) // ������� ����� 
   
	   {
       IM_ADCrab.a[2]   = IM_ADCrab.aI;          // ADC
       IM_ADCrab.cnt[2] = IM_ADCrab.cntI;       // �������
       IM_ADCrab.fL[2] = 1;                     // ������� ����������
       IM_ADCrab.aI = IM_ADCrab.cntI=0;    // ���������� ��� ���� ��������������
       
			 //  ������ ����� ����������
       // ���������  �����                   // !!!!!!!!!!!!!!!!!!!!!!!!!!!!! 
       IM_ADCrab.CnAI= IM_ADCrab.NLCn[3];    // ���� ���������� ����� IM_ADCrab.NLCn[]
			 ADC2->CSR &= (uint8_t)(~ADC2_CSR_CH); //  Clear the ADC2 channels 
			 /* ���� ��� �����  */
       ADC2->CSR |= (uint8_t)(IM_ADCrab.NCn[3]); //Select the ADC2 channel
			 }   
   
 }
 else
  if (IM_ADCrab.CnAI==3)            //  3-�����!! 0000000000000000000000000000000000000000000000
 {
  IM_ADCrab.aI += IM_ADCrab.tmpI;
  
     if(IM_ADCrab.cntI >= IM_ADCrab.ns[3]) // ������� ����� 
   
	   {
       IM_ADCrab.a[3]   = IM_ADCrab.aI;          // ADC
       IM_ADCrab.cnt[3] = IM_ADCrab.cntI;       // �������
       IM_ADCrab.fL[3] = 1;                     // ������� ����������
       IM_ADCrab.aI = IM_ADCrab.cntI=0;    // ���������� ��� ���� ��������������
       
			 //  ������ ����� ����������
       // ���������  �����                   // !!!!!!!!!!!!!!!!!!!!!!!!!!!!! 
       IM_ADCrab.CnAI= IM_ADCrab.NLCn[0];    // ���� ���������� ����� IM_ADCrab.NLCn[]
			 ADC2->CSR &= (uint8_t)(~ADC2_CSR_CH); //  Clear the ADC2 channels 
			 /* ���� ��� �����  */
       ADC2->CSR |= (uint8_t)(IM_ADCrab.NCn[0]); //Select the ADC2 channel
			 }   
   
 }
#endif
 
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
// ���� � ������ - �������

void IM_ADC_Config(u16 Lsr0,   //���������� ���������� �� 0 ������, ���� 0 - �� 1
                   u16 Lsr1,   //���������� ���������� �� 1 ������, ���� 0 - �� 1
                   u16 Lsr2,   //���������� ���������� �� 2 ������, ���� 0 - �� 1
                   u16 Lsr3,   //���������� ���������� �� 3 ������, ���� 0 - �� 1
                   u8  prsc    // Prescaler ������ ��� <=7, ���� ������, �� =7 
                   )
{
ADC2_Channel_TypeDef Ch;

  ADC2_DeInit();

//IM_ADCr  IM_ADCrab - ��������
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
  prsc =(u8) (prsc<<((u8)4));    // ����� ������ ADC2_PresSel_TypeDef
   
  //IM_ADCrab.zr = IM_ADC_reg; //  �� �������

  //////////////////////////////////////////
	///��������� ������� - ��/��� ������������ !!!!
	GPIO_Init(GPIOB, (GPIO_Pin_TypeDef)GPIO_PIN_0, GPIO_MODE_IN_FL_NO_IT);
	//GPIO_Init(GPIOB, (GPIO_Pin_TypeDef)GPIO_PIN_1, GPIO_MODE_IN_FL_NO_IT);
	//GPIO_Init(GPIOB, (GPIO_Pin_TypeDef)GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);
	//GPIO_Init(GPIOB, (GPIO_Pin_TypeDef)GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);
	//GPIO_Init(GPIOB, (GPIO_Pin_TypeDef)GPIO_PIN_4, GPIO_MODE_IN_FL_NO_IT);
  //GPIO_Init(GPIOB, (GPIO_Pin_TypeDef)GPIO_PIN_5, GPIO_MODE_IN_FL_NO_IT);
	//GPIO_Init(GPIOB, (GPIO_Pin_TypeDef)GPIO_PIN_6, GPIO_MODE_IN_FL_NO_IT);
	//GPIO_Init(GPIOB, (GPIO_Pin_TypeDef)GPIO_PIN_7, GPIO_MODE_IN_FL_NO_IT);
	
  // � ����������� � ������������ ������ !!!!!
  // ���������� ����� = ���������� ����� ��� =
  //                    ����� ���� ���� �� GPIO_PIN_�
     IM_ADCrab.NCn[0] =   0;
     IM_ADCrab.NCn[1] =   3;
     IM_ADCrab.NCn[2] =   4;
     IM_ADCrab.NCn[3] =   5;
	// u8     NLCn[4];
	// ���������� !!! ��������� !!!
	   IM_ADCrab.NLCn[0] = 0; // ����� ������ � ������� ������� � �����������
		                        // ���� ������ �� "1" ��� �����!!
		 IM_ADCrab.NLCn[1] = 1;
		 IM_ADCrab.NLCn[2] = 2;
		 IM_ADCrab.NLCn[3] = 3; // �������� �� 0 �����
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


/*  u8    fA;   // =1 - ��������� ��������� ���������
   float A;  // ��������� ��������� ����� ����������
   /// �����������
   u8 FN;          // =1 ��������� ���������� ���������
   u16 N,Ns;     //  ������� ����������
*/


////////////////////////////////////////////////////////////////////
// 1- ��� ���� �� 1 ��������� � IM_ADCr
// ������ �� ����� IM_ADCr[i].fA = 1; 
u8 IM_ADC_handler(void)
{
////////////////////////////////////////////

u32      aa  ; 
u8 i,ii=0;
for(i=0;i<4;i++)
{
   if(IM_ADCrab.fL[i]==1)   // ch0 - 
    {
                // ������ ���������� 
   aa = IM_ADCrab.a[i];
   IM_ADCrab.fL[i] = 0;

// ���������� ����������
	 IM_ADCrab.cnt_[i]++;

   IM_ADCr[i].fA = 1;   // ���� ����������
   IM_ADCr[i].A  = aa* IM_ADCrab.fns[i]  ;  // ����������
	 IM_ADCr[i].IA = (u16)(IM_ADCr[i].A*10.+0.5);
   IM_ADCr[i].N++;              // ������� ����������� �� ������
	 ii=1;
     }

//    � ������� ������� - ��������

} // for
return ii ;  // 1- ��� ���� �� 1 ���������
}

#if 0
/////////////////////
/////////////////////////////////////////////////////////////////////////
////       ��� ������������ ��� ����������
void IM_ADC_Config_t(void) 
									
{

  ADC2_DeInit();
    GPIO_Init(GPIOB, (GPIO_Pin_TypeDef)GPIO_PIN_0, GPIO_MODE_IN_FL_NO_IT);
    GPIO_Init(GPIOB, (GPIO_Pin_TypeDef)GPIO_PIN_1, GPIO_MODE_IN_FL_NO_IT);
  
   
  
	ADC2_Init( ADC2_CONVERSIONMODE_SINGLE , // ������ ������ - �������
	           ADC2_CHANNEL_1,    // ����� ������ - ������ �����!!!
	           ADC2_PRESSEL_FCPU_D2, // �������� �������������� - ������ �����
	            
	           ADC2_EXTTRIG_TIM, DISABLE,   // ����
	           ADC2_ALIGN_RIGHT,            // ������ ������� ������!
	           ADC2_SCHMITTTRIG_CHANNEL1,DISABLE);   // ����
	
  ADC2_Cmd(ENABLE); // ��� �������
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

// ��� ������ - �������� ���� �������������� 

u16 TI___t1,TI___t;

u16 IM_ADC_get_t(void)  
{
	volatile u16 t,t1,c=0;
	ADC2_ClearFlag( );    
	ADC2_StartConversion( );
	
	// ����������� �� ��������������??
	while( ADC2_GetFlagStatus( ) == RESET )
	 {c++;
	 }  
	 // ��� ������� - ��������
//	     if ((ADC2->CR2 & ADC2_CR2_ALIGN) != 0) /* Right alignment */
//    {
//        /* Read LSB first */
//        templ = ADC2->DRL;
//        /* Then read MSB */
//        temph = ADC2->DRH;
//      temph = (uint16_t)(templ | (uint16_t)(temph << (uint8_t)8));
//    }
	   t= ADC2_GetConversionValue( );
    *(((char*)&t1)+1)      = ADC2->DRL;      // ����� DRL
    *(((char*)&t1)+0)      = ADC2->DRH;      // ������� DRH

    TI___t1 = t1;
    TI___t  = t;
	 ADC2_ClearFlag( );
   return t;
}	

#endif