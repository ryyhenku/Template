#include "ssc_adapter.h"
#include "subsys_period_timer.h"


static void 

uint16_t HW_Init(void)
{
    et1100_init();
    period_timer_ops_t* timer2 = period_timer_ops_get_by_name("Timer2_Period");

    ret = period_timer_start(timer2,1000,call_back);

}
void HW_Release(void){

}