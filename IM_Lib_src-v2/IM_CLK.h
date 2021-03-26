
#include "stm8s.h"

void CLK_Config(void); // �������� ������� �����, ���� �� ��������� - �������� ���������� ����� �� 16 ���
void clk_control(void);




extern CLK_Source_TypeDef source_;
extern u16 cnt_swclk;

void CLK_SWITCH_HSI(void);  // ����������� �� ���������� �����
#define HSI_prescaler CLK_PRESCALER_HSIDIV1
 // ������� ����������� ������:
 // CLK_PRESCALER_HSIDIV1 - 16 ��� 
 // CLK_PRESCALER_HSIDIV2 - 8 ���
 // CLK_PRESCALER_HSIDIV4 - 4 ���
 // CLK_PRESCALER_HSIDIV8 - 2 ���