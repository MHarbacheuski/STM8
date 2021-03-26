#include "IM_CLK.h"



CLK_Source_TypeDef source_;
u16 cnt_swclk;

  void CLK_SWITCH_HSI(void)  // переключить на внутренний кварц
 {
	ErrorStatus status = ERROR;
	
  CLK_HSIPrescalerConfig(HSI_prescaler);
   
  status =  CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO,CLK_SOURCE_HSI,DISABLE,CLK_CURRENTCLOCKSTATE_DISABLE);	   
 }

	void CLK_Config(void)
{
	ErrorStatus status = ERROR;
	
  CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
  
  status =  CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO,CLK_SOURCE_HSE,DISABLE,CLK_CURRENTCLOCKSTATE_DISABLE);

if(status == SUCCESS)	
{	
	//CLK_HSECmd(ENABLE);
	CLK_HSICmd(DISABLE);
	
	CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
	
	//CLK_ClockSecuritySystemEnable();
	//CLK_ITConfig(CLK_IT_CSSD,ENABLE);
}	
else
{
	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
	CLK_HSICmd(ENABLE);
	cnt_swclk ++;
}

	CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C,DISABLE);
//	CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI,DISABLE);
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1,DISABLE);
//	CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART2,DISABLE);
//	CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART3,DISABLE);
	//CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER6,DISABLE);
	//CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER5,DISABLE);
	//CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2,DISABLE);
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER3,DISABLE);
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1,DISABLE);
//	CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU,DISABLE);
	
}

void clk_control(void)
{
	source_ = CLK_GetSYSCLKSource();
	if(source_ != CLK_SOURCE_HSE)
	 {
	    cnt_swclk ++;
			CLK_Config();
   }			 
}


