#include "main.h"
#include "stm8s.h"

///////////
extern u16 T1[100]; // ������� �� ������� ����
extern u8 NT1;
extern u16 T2[100]; // ������� �������� ������� ��� � �1 - ��� ������������

/////////////////
//u8 NT1 = 100;

u8 b_f(u16 A);  // A - ��� ���� �� ������� T1  ������ NT1 
u8 b_f1(u16 A); //���� ������, ��������� ����� if
u8 b_f2(u16 A); //���� ������, ���������� ��������� � ��������������� ����������
u8 b_f3(u16 A); //���� ������, ������� ���������� �����������
u8 P_f(u16 A);//���������������� �����
u8 bp_f4(u16 A);// ��������� �����
////////////////////////////////////////////
volatile u8 i,j,n,k1,k2,kkk; //��� �������� ����� ��������� �������
volatile u16 W;

void main(void)
{
 kkk=0xff;
 NT1 =100;
 n=NT1;
 
k1=k2=0;  // ��������� 1 - �������� ����� User clock
          // � Core Registr
          // ���� ����� ����� � Watch ��������NT1
					// � ������� �������
//  "����" - �������� ���� ��� ������ ������� ������ 
for (i=0;i<n;i++)
 {
	W=T1[i];   //  �� ����������
	//j=b_f(W); 
  j=i;        // ������ ������
	if( j == i)
	  k1++ ;      // ������� ���������� ��� ��������
		           // �� ����� �������������� ������ � ���� ����� ������������ 
							// ���� �� ���� ������
 ///////
	W=T2[i];   //  ��  �� ����������
	//j=b_f(W);
  j=kkk;	
	if( j == 0xff)
	  k2++ ;      // ������� ���������� ��� ��������
 }
k1=k2=0;  // ��������� - ����� "����", ����� User clock
//////////////
//  ������� ���� ///// 
for (i=0;i<n;i++)
 {
	W=T1[i];   //  �� ����������
	j=bp_f4(W); 
  //j=P_f(W);
	
  //j=i;        // ������ ������
	if( j == i)
	  k1++ ;      // ������� ���������� ��� ��������
		           // �� ����� �������������� ������ � ���� ����� ������������ 
							// ���� �� ���� ������
 ///////
	W=T2[i];   //  ��  �� ����������
	j=bp_f4(W);
	//j=P_f(W);
	
  //j=kkk;	
	if( j == 0xff)
	  k2++ ;      // ������� ���������� ��� ��������
 }
i=j;  // ��������� - ����� ��� �����, �� ������ ������ ����













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
	
