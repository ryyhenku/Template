


#include <FreeRTOS.h>
#include <stm32f4xx.h>
#include <misc.h>
extern void Debug_UartInit(void);

void MAINTask(void *parm)
{
    
    for( ; ; )
    {
      printf("Hello World!\r\n");
      vTaskDelay(1000);
      /* Should not reach here. */
    }
}

void main()
{
    Debug_UartInit();
    printf("Application Start!\r\n");
    static StaticTask_t MAINTaskTCB;
    static StackType_t MAINTaskStack[ 1024 ];
    NVIC_PriorityGroupConfig(NVIC_PriorityGroup_4);


        //静态创建任务
    ( void ) xTaskCreateStatic( MAINTask,
                                "main_task",
                                1024,
                                NULL,
                                configMAX_PRIORITIES - 1U,
                                &( MAINTaskStack[ 0 ] ),
                                &( MAINTaskTCB ) );


                                    /*开始任务调度 */
    vTaskStartScheduler();



    return 0;
}