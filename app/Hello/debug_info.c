#include <stdio.h>
#include <unistd.h>
#include <errno.h>

#include "stm32f4xx.h"
#include "stm32f4xx_rcc.h"
#include "stm32f4xx_gpio.h"
#include "stm32f4xx_usart.h"

void Debug_UartInit(void)
{
    GPIO_InitTypeDef GPIO_InitStructure;
    USART_InitTypeDef USART_InitStructure;
    

    RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_GPIOB, ENABLE);   
    RCC_APB2PeriphClockCmd(RCC_APB2Periph_USART1, ENABLE);  
    
    GPIO_PinAFConfig(GPIOB, GPIO_PinSource6, GPIO_AF_USART1); 
    GPIO_PinAFConfig(GPIOB, GPIO_PinSource7, GPIO_AF_USART1); 

    GPIO_InitStructure.GPIO_Pin = GPIO_Pin_6|GPIO_Pin_7;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF;          // 复用功能
    GPIO_InitStructure.GPIO_Speed = GPIO_Fast_Speed;
    GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;        // 推挽输出
    GPIO_Init(GPIOB, &GPIO_InitStructure);
    
    USART_InitStructure.USART_BaudRate = 115200;
    USART_InitStructure.USART_WordLength = USART_WordLength_8b;
    USART_InitStructure.USART_StopBits = USART_StopBits_1;
    USART_InitStructure.USART_Parity = USART_Parity_No;
    USART_InitStructure.USART_HardwareFlowControl = USART_HardwareFlowControl_None;
    USART_InitStructure.USART_Mode = USART_Mode_Rx | USART_Mode_Tx;
    
    USART_Init(USART1, &USART_InitStructure);
    
    // 5. 使能USART
    USART_Cmd(USART1, ENABLE);
}


// 重写_write系统调用
int _write(int file, char *ptr, int len)
{
    int i;
    
    if (file == STDOUT_FILENO || file == STDERR_FILENO)
    {
        for (i = 0; i < len; i++)
        {
            // 等待发送缓冲区为空
            while (USART_GetFlagStatus(USART1, USART_FLAG_TXE) == RESET);
            
            // 发送一个字符
            USART_SendData(USART1, (uint8_t)ptr[i]);
        }
        return i;
    }
    
    errno = EIO;
    return -1;
}