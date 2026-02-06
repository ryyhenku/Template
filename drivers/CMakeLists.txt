cmake_minimum_required(VERSION 3.5.0)

if(Board STREQUAL "stm32f103_ethercat")
    set_property(GLOBAL PROPERTY Driver_Sources

    )
    set(GLOBAL PROPERTY Driver_Includes

    )

elseif(Board STREQUAL "HPM6450")

    set_property(GLOBAL PROPERTY Driver_Sources
        ${PATH_WORKSPACE_ROOT}/board/HPM6450/board_bsp.c
        ${PATH_WORKSPACE_ROOT}/board/HPM6450/bsp/hpm6450dp_uart12.c
    )
    set_property(GLOBAL PROPERTY Driver_Includes
        ${PATH_WORKSPACE_ROOT}/drivers/HPM/HPM6700/HPM6750/
        ${PATH_WORKSPACE_ROOT}/drivers/HPM/HPM6700/ip/
        ${PATH_WORKSPACE_ROOT}/drivers/HPM/drivers/inc/
    )
endif()