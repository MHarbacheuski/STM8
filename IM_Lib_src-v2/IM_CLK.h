
#include "stm8s.h"

void CLK_Config(void); // включить внешний кварц, если не включился - включить внутренний кварц на 16 МГц
void clk_control(void);




extern CLK_Source_TypeDef source_;
extern u16 cnt_swclk;

void CLK_SWITCH_HSI(void);  // переключить на внутренний кварц
#define HSI_prescaler CLK_PRESCALER_HSIDIV1
 // частота внутреннего кварца:
 // CLK_PRESCALER_HSIDIV1 - 16 МГц 
 // CLK_PRESCALER_HSIDIV2 - 8 МГц
 // CLK_PRESCALER_HSIDIV4 - 4 МГц
 // CLK_PRESCALER_HSIDIV8 - 2 МГц