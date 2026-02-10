#include "subsys_period_timer.h"
#include "subsys_uart.h"
#include "serial_debug.h"
#include <stdio.h>
#include "stm32f10x_tim.h"
#include "ET1100.h"
uint32_t count = 0;

extern uart_ops_t* __debug_serial;


void call_back()
{
    count ++;
    if(count >= 1000) {
        count = 0;
        __debug_serial->pfn_uart_write("[Debug]Application Start!\r\n",27);
    }

}

int main()
{
    int ret;
    board_init();
    ret = init_debug_serial("Debug_UART",115200,Data_Bits_8,Stop_Bits_1,None_Parity);
    if (ret != 0) {
        return ret;
    }
    //period_timer_ops_t* timer2 = period_timer_ops_get_by_name("Timer2_Period");

   // ret = period_timer_start(timer2,1000,call_back);


    et1100_init();
    uint8_t buf[2];
    et1100_read(buf,0x140,1);
    while(1);

}
