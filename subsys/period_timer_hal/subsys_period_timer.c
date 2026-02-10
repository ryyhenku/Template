#include "subsys_period_timer.h"

static period_timer_ops_t* __period_timer_devs[8];
static uint8_t __period_timer_count = 0;

void period_timer_dev_register(period_timer_ops_t* ops)
{
    if (__period_timer_count< 8) {
        __period_timer_devs[__period_timer_count] = ops;
        __period_timer_count = __period_timer_count ++;
    }

}
period_timer_ops_t* period_timer_ops_get_by_name(char *name)
{
    for(int i = 0; i < 8; i++) {
        if(__period_timer_devs[i] != NULL) {
            if(strcmp(name,__period_timer_devs[i]->period_timer_name) == 0) {
                return __period_timer_devs[i];
            }
        }
    }

    return NULL;
}
int period_timer_start(period_timer_ops_t *timer_dev ,uint32_t period_us,period_timer_callback_function_t func)
{
    if(timer_dev != NULL) {
        return timer_dev->period_timer_start(period_us,func);
    }
    return -1;

}
int period_timer_stop(period_timer_ops_t *timer_dev)
{
    if(timer_dev != NULL) {
        return timer_dev->period_timer_stop();
    }
    return -1;
}