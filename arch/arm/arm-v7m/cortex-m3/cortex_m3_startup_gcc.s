.syntax unified
.cpu cortex-m3
.thumb

.global isr_vector
.global Reset_Handler

.section .isr_vector,"a",%progbits
isr_vector:
    .word    __main_stack_top
    .word    Reset_Handler              // Reset Handler
    .word    NMI_Handler                // NMI Handler
    .word    HardFault_Handler          // Hard Fault Handler
    .word    MemManage_Handler          // MPU Fault Handler
    .word    BusFault_Handler           // Bus Fault Handler
    .word    UsageFault_Handler         // Usage Fault Handler
    .word    0                          // Reserved
    .word    0                          // Reserved
    .word    0                          // Reserved
    .word    0                          // Reserved
    .word    SVC_Handler                // SVCall Handler
    .word    DebugMon_Handler           // Debug Monitor Handler
    .word    0                          // Reserved
    .word    PendSV_Handler             // PendSV Handler
    .word    SysTick_Handler            // SysTick Handler//
    .word    WWDG_IRQHandler            // Window Watchdog
    .word    PVD_IRQHandler             // PVD through EXTI Line detect
    .word    TAMPER_IRQHandler          // Tamper
    .word    RTC_IRQHandler             // RTC
    .word    FLASH_IRQHandler           // Flash
    .word    RCC_IRQHandler             // RCC
    .word    EXTI0_IRQHandler           // EXTI Line 0
    .word    EXTI1_IRQHandler           // EXTI Line 1
    .word    EXTI2_IRQHandler           // EXTI Line 2
    .word    EXTI3_IRQHandler           // EXTI Line 3
    .word    EXTI4_IRQHandler           // EXTI Line 4
    .word    DMA1_Channel1_IRQHandler   // DMA1 Channel 1
    .word    DMA1_Channel2_IRQHandler   // DMA1 Channel 2
    .word    DMA1_Channel3_IRQHandler   // DMA1 Channel 3
    .word    DMA1_Channel4_IRQHandler   // DMA1 Channel 4
    .word    DMA1_Channel5_IRQHandler   // DMA1 Channel 5
    .word    DMA1_Channel6_IRQHandler   // DMA1 Channel 6
    .word    DMA1_Channel7_IRQHandler   // DMA1 Channel 7
    .word    ADC1_2_IRQHandler          // ADC1 & ADC2
    .word    USB_HP_CAN1_TX_IRQHandler  // USB High Priority or CAN1 TX
    .word    USB_LP_CAN1_RX0_IRQHandler // USB Low  Priority or CAN1 RX0
    .word    CAN1_RX1_IRQHandler        // CAN1 RX1
    .word    CAN1_SCE_IRQHandler        // CAN1 SCE
    .word    EXTI9_5_IRQHandler         // EXTI Line 9..5
    .word    TIM1_BRK_IRQHandler        // TIM1 Break
    .word    TIM1_UP_IRQHandler         // TIM1 Update
    .word    TIM1_TRG_COM_IRQHandler    // TIM1 Trigger and Commutation
    .word    TIM1_CC_IRQHandler         // TIM1 Capture Compare
    .word    TIM2_IRQHandler            // TIM2
    .word    TIM3_IRQHandler            // TIM3
    .word    TIM4_IRQHandler            // TIM4
    .word    I2C1_EV_IRQHandler         // I2C1 Event
    .word    I2C1_ER_IRQHandler         // I2C1 Error
    .word    I2C2_EV_IRQHandler         // I2C2 Event
    .word    I2C2_ER_IRQHandler         // I2C2 Error
    .word    SPI1_IRQHandler            // SPI1
    .word    SPI2_IRQHandler            // SPI2
    .word    USART1_IRQHandler          // USART1
    .word    USART2_IRQHandler          // USART2
    .word    USART3_IRQHandler          // USART3
    .word    EXTI15_10_IRQHandler       // EXTI Line 15..10
    .word    RTCAlarm_IRQHandler        // RTC Alarm through EXTI Line
    .word    USBWakeUp_IRQHandler       // USB Wakeup from suspend
    .word    TIM8_BRK_IRQHandler        // TIM8 Break
    .word    TIM8_UP_IRQHandler         // TIM8 Update
    .word    TIM8_TRG_COM_IRQHandler    // TIM8 Trigger and Commutation
    .word    TIM8_CC_IRQHandler         // TIM8 Capture Compare
    .word    ADC3_IRQHandler            // ADC3
    .word    FSMC_IRQHandler            // FSMC
    .word    SDIO_IRQHandler            // SDIO
    .word    TIM5_IRQHandler            // TIM5
    .word    SPI3_IRQHandler            // SPI3
    .word    UART4_IRQHandler           // UART4
    .word    UART5_IRQHandler           // UART5
    .word    TIM6_IRQHandler            // TIM6
    .word    TIM7_IRQHandler            // TIM7
    .word    DMA2_Channel1_IRQHandler   // DMA2 Channel1
    .word    DMA2_Channel2_IRQHandler   // DMA2 Channel2
    .word    DMA2_Channel3_IRQHandler   // DMA2 Channel3
    .word    DMA2_Channel4_5_IRQHandler // DMA2 Channel4 & Channel5

/* Reset_Handler */
.section .text.Reset_Handler
.type Reset_Handler, %function
Reset_Handler:
  /* 初始化栈指针 */
  ldr   sp, =__main_stack_top

  /* 复制数据段从Flash到RAM */
  ldr   r0, =_sdata
  ldr   r1, =_edata
  ldr   r2, =_sidata
  movs  r3, #0
  b     LoopCopyDataInit

CopyDataInit:
  ldr   r4, [r2, r3]
  str   r4, [r0, r3]
  adds  r3, r3, #4

LoopCopyDataInit:
  adds  r4, r0, r3
  cmp   r4, r1
  bcc   CopyDataInit

  /* 清零BSS段 */
  ldr   r2, =__bss_start__
  ldr   r4, =__bss_end__
  movs  r3, #0
  b     LoopFillZerobss

FillZerobss:
  str   r3, [r2]
  adds  r2, r2, #4

LoopFillZerobss:
  cmp   r2, r4
  bcc   FillZerobss

  /* 配置系统时钟 */
  bl    SystemInit

  /* 跳转到main函数 */
  bl    main



.size Reset_Handler, .-Reset_Handler

/* 默认中断处理函数 */
.section  .text.Default_Handler,"ax",%progbits
Default_Handler:
Infinite_Loop:
  b  Infinite_Loop
.size  Default_Handler, .-Default_Handler

/* 宏定义：简化弱定义代码 */
.macro def_default_handler handler_name
    .weak  \handler_name
    .thumb_set \handler_name, Default_Handler
.endm


def_default_handler NMI_Handler                // NMI Handler
def_default_handler HardFault_Handler          // Hard Fault Handler
def_default_handler MemManage_Handler          // MPU Fault Handler
def_default_handler BusFault_Handler           // Bus Fault Handler
def_default_handler UsageFault_Handler         // Usage Fault Handler
def_default_handler SVC_Handler                // SVCall Handler
def_default_handler DebugMon_Handler           // Debug Monitor Handler
def_default_handler PendSV_Handler             // PendSV Handler
def_default_handler SysTick_Handler            // SysTick Handler//

def_default_handler WWDG_IRQHandler
def_default_handler PVD_IRQHandler
def_default_handler TAMPER_IRQHandler
def_default_handler RTC_IRQHandler
def_default_handler FLASH_IRQHandler
def_default_handler RCC_IRQHandler
def_default_handler EXTI0_IRQHandler
def_default_handler EXTI1_IRQHandler
def_default_handler EXTI2_IRQHandler
def_default_handler EXTI3_IRQHandler
def_default_handler EXTI4_IRQHandler
def_default_handler DMA1_Channel1_IRQHandler
def_default_handler DMA1_Channel2_IRQHandler
def_default_handler DMA1_Channel3_IRQHandler
def_default_handler DMA1_Channel4_IRQHandler
def_default_handler DMA1_Channel5_IRQHandler
def_default_handler DMA1_Channel6_IRQHandler
def_default_handler DMA1_Channel7_IRQHandler
def_default_handler ADC1_2_IRQHandler
def_default_handler USB_HP_CAN1_TX_IRQHandler
def_default_handler USB_LP_CAN1_RX0_IRQHandler
def_default_handler CAN1_RX1_IRQHandler
def_default_handler CAN1_SCE_IRQHandler
def_default_handler EXTI9_5_IRQHandler
def_default_handler TIM1_BRK_IRQHandler
def_default_handler TIM1_UP_IRQHandler
def_default_handler TIM1_TRG_COM_IRQHandler
def_default_handler TIM1_CC_IRQHandler
@ def_default_handler TIM2_IRQHandler
def_default_handler TIM3_IRQHandler
def_default_handler TIM4_IRQHandler
def_default_handler I2C1_EV_IRQHandler
def_default_handler I2C1_ER_IRQHandler
def_default_handler I2C2_EV_IRQHandler
def_default_handler I2C2_ER_IRQHandler
def_default_handler SPI1_IRQHandler
def_default_handler SPI2_IRQHandler
def_default_handler USART1_IRQHandler
def_default_handler USART2_IRQHandler
def_default_handler USART3_IRQHandler
def_default_handler EXTI15_10_IRQHandler
def_default_handler RTCAlarm_IRQHandler
def_default_handler USBWakeUp_IRQHandler
def_default_handler TIM8_BRK_IRQHandler
def_default_handler TIM8_UP_IRQHandler
def_default_handler TIM8_TRG_COM_IRQHandler
def_default_handler TIM8_CC_IRQHandler
def_default_handler ADC3_IRQHandler
def_default_handler FSMC_IRQHandler
def_default_handler SDIO_IRQHandler
def_default_handler TIM5_IRQHandler
def_default_handler SPI3_IRQHandler
def_default_handler UART4_IRQHandler
def_default_handler UART5_IRQHandler
def_default_handler TIM6_IRQHandler
def_default_handler TIM7_IRQHandler
def_default_handler DMA2_Channel1_IRQHandler
def_default_handler DMA2_Channel2_IRQHandler
def_default_handler DMA2_Channel3_IRQHandler
def_default_handler DMA2_Channel4_5_IRQHandler


