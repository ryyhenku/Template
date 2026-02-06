cmake_minimum_required(VERSION 3.5.0)

if(Platform STREQUAL "arm")

    set_property(GLOBAL PROPERTY Arch_Sources
        ${PATH_WORKSPACE_ROOT}/arch/arm/arm-v7m/cortex-m3/cortex_m3_startup_gcc.s
        ${PATH_WORKSPACE_ROOT}/drivers/STM32F10x_StdPeriph_Driver/src/misc.c
    )
    set_property(GLOBAL PROPERTY Arch_Includes
        ${PATH_WORKSPACE_ROOT}/arch/arm/arm-v7m/cortex-m3
    )

elseif(Platform STREQUAL "riscv")


    set(STARTUP_ASM
        ${PATH_WORKSPACE_ROOT}/arch/riscv/hpm/toolchains/gcc/start.S
    )
    set_source_files_properties(${STARTUP_ASM} PROPERTIES
        LANGUAGE ASM
        COMPILE_FLAGS "-march=rv32imafdc -mabi=ilp32f"
    )
    set_property(GLOBAL PROPERTY STARTUP_ASM ${STARTUP_ASM})

    set_property(GLOBAL PROPERTY Arch_Sources
        ${PATH_WORKSPACE_ROOT}/arch/riscv/hpm/toolchains/gcc/stdio_weak.c
        ${PATH_WORKSPACE_ROOT}/arch/riscv/l1c/hpm_l1c_drv.c
        ${PATH_WORKSPACE_ROOT}/arch/riscv/hpm/toolchains/reset.c
        ${PATH_WORKSPACE_ROOT}/arch/riscv/hpm/toolchains/initfini.c
        ${PATH_WORKSPACE_ROOT}/arch/riscv/hpm/system.c
        ${PATH_WORKSPACE_ROOT}/arch/riscv/hpm/trap.c
    )
    set_property(GLOBAL PROPERTY Arch_Includes
        ${PATH_WORKSPACE_ROOT}/arch/
        ${PATH_WORKSPACE_ROOT}/arch/riscv/hpm/
        ${PATH_WORKSPACE_ROOT}/arch/riscv/l1c/
    )
endif()