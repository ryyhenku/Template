cmake_minimum_required(VERSION 3.5.0)

if(Board STREQUAL "stm32f103_ethercat")
    set_property(GLOBAL PROPERTY Board_Sources

    )
    set_property(GLOBAL PROPERTY Board_Includes

    )

elseif(Board STREQUAL "HPM6450")


    set_property(GLOBAL PROPERTY LINKER_SCRIPT 
        ${PATH_WORKSPACE_ROOT}/board/HPM6450/ram.ld
    )
    set_property(GLOBAL PROPERTY Board_Sources
        ${PATH_WORKSPACE_ROOT}/drivers/HPM/drivers/src/hpm_pcfg_drv.c
        ${PATH_WORKSPACE_ROOT}/drivers/HPM/drivers/src/hpm_pllctl_drv.c
        ${PATH_WORKSPACE_ROOT}/drivers/HPM/drivers/src/hpm_uart_drv.c
        ${PATH_WORKSPACE_ROOT}/drivers/HPM/HPM6700/HPM6750/hpm_clock_drv.c
        ${PATH_WORKSPACE_ROOT}/drivers/HPM/HPM6700/HPM6750/hpm_sysctl_drv.c
    )
    set(GLOBAL PROPERTY Board_Includes
        ${PATH_WORKSPACE_ROOT}/drivers/HPM/HPM6700/HPM6750/
        ${PATH_WORKSPACE_ROOT}/drivers/HPM/HPM6700/ip/
        ${PATH_WORKSPACE_ROOT}/drivers/HPM/drivers/inc/
    )


endif()




# 指定启动文件
