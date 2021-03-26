
extern unsigned char TM_scr[32];

void initML(void);

unsigned  char TM_reset(void);
unsigned  char TM_wrbit (unsigned  char a);
unsigned  char TM_wrbit11 (unsigned  char a);
unsigned  char TM_wrbyte(unsigned  char a);
unsigned  char TM_rdsern(void);
unsigned char RT_sec_rd(unsigned long *tt);
unsigned char RT_sec_wr(unsigned long tt);
unsigned  char TM_memwr(unsigned  int addr);
unsigned  char TM_memrd(unsigned  int addr);
//float  Temper(void);
float  Temper(unsigned  char n);

void testwrr(void);