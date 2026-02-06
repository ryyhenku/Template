cmake_minimum_required(VERSION 3.5.0)

set_property(GLOBAL PROPERTY Subsys_Sources
    ${PATH_WORKSPACE_ROOT}/subsys/uart_hal/subsys_uart.c
    ${PATH_WORKSPACE_ROOT}/subsys/spi_hal/subsys_spi.c
)
set_property(GLOBAL PROPERTY Subsys_Includes
    ${PATH_WORKSPACE_ROOT}/subsys/uart_hal/
    ${PATH_WORKSPACE_ROOT}/subsys/uart_spi/
)
