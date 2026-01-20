# 编译工具链
# 请确保已经添加到环境变量
SET(CMAKE_SYSTEM_NAME Generic)
SET(CMAKE_SYSTEM_PROCESSOR cortex-m4)

# 指定工具链路径
SET(TOOLCHAIN_PATH "C:/Program Files (x86)/GNU Arm Embedded Toolchain/10 2021.10")

# 指定交叉编译的编译工具链
set(CMAKE_C_COMPILER   ${TOOLCHAIN_PATH}/bin/arm-none-eabi-gcc.exe)
set(CMAKE_CXX_COMPILER ${TOOLCHAIN_PATH}/bin/arm-none-eabi-g++.exe)
set(CMAKE_ASM_COMPILER ${TOOLCHAIN_PATH}/bin/arm-none-eabi-gcc.exe)
set(CMAKE_AR           ${TOOLCHAIN_PATH}/bin/arm-none-eabi-ar.exe)
set(AS                 ${TOOLCHAIN_PATH}/bin/arm-none-eabi-as.exe)
set(OBJCOPY            ${TOOLCHAIN_PATH}/bin/arm-none-eabi-objcopy.exe)
set(OBJDUMP            ${TOOLCHAIN_PATH}/bin/arm-none-eabi-objdump.exe)
set(SIZE               ${TOOLCHAIN_PATH}/bin/arm-none-eabi-size.exe)

# 路径查找
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

# this makes the test compiles use static library option so that we don't need to pre-set linker flags and scripts
# 通过设置 CMAKE_TRY_COMPILE_TARGET_TYPE 为 STATIC_LIBRARY，你可以避免在交叉编译过程中因为尝试生成并执行目标平台不可运行的可执行文件而导致的编译失败问题。
SET(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)


# 包含gcc头文件路径
SET(SYSTEM_PATH "-isystem ${TOOLCHAIN_PATH}/include")

# 定义通用编译器参数；
# ${MCPU_FLAGS}   处理器内核信息
# ${VFP_FLAGS}    浮点运算单元类型
# ${SYSTEM_PATH}  编译器头文件路径
SET(CFCOMMON
    "${MCPU_FLAGS} ${VFP_FLAGS} --specs=nosys.specs -Wall -fmessage-length=0 -ffunction-sections -fdata-sections"
)

# # 定义最快运行速度发行模式的编译参数；
# SET(CMAKE_C_FLAGS_RELEASE "-Os  ${CFCOMMON}")
# SET(CMAKE_CXX_FLAGS_RELEASE "-Os  ${CFCOMMON} -fno-exceptions")
# SET(CMAKE_ASM_FLAGS_RELEASE "${MCPU_FLAGS} ${VFP_FLAGS} -x assembler-with-cpp")

# # 定义最小尺寸且包含调试信息的编译参数；
# SET(CMAKE_C_FLAGS_RELWITHDEBINFO "-Os -g  ${CFCOMMON}")
# SET(CMAKE_CXX_FLAGS_RELWITHDEBINFO "-Os -g  ${CFCOMMON} -fno-exceptions")
# SET(CMAKE_ASM_FLAGS_RELWITHDEBINFO "${MCPU_FLAGS} ${VFP_FLAGS} -x assembler-with-cpp")

# # 定义最小尺寸的编译参数；
# SET(CMAKE_C_FLAGS_MINSIZEREL "-Os  ${CFCOMMON}")
# SET(CMAKE_CXX_FLAGS_MINSIZEREL "-Os  ${CFCOMMON} -fno-exceptions")
# SET(CMAKE_ASM_FLAGS_MINSIZEREL "${MCPU_FLAGS} ${VFP_FLAGS} -x assembler-with-cpp")

# 定义调试模式编译参数；
SET(CMAKE_C_FLAGS "-O0 -g  ${CFCOMMON}")
SET(CMAKE_CXX_FLAGS "-O0 -g  ${CFCOMMON} -fno-exceptions")
SET(CMAKE_ASM_FLAGS "-O0 -g -mthumb -mcpu=cortex-m4")

# IF("${CMAKE_BUILD_TYPE}" STREQUAL "Release")
#   MESSAGE(STATUS "**** Maximum optimization for speed ****")
# ELSEIF("${CMAKE_BUILD_TYPE}" STREQUAL "RelWithDebInfo")
#   MESSAGE(STATUS "**** Maximum optimization for size, debug info included ****")
# ELSEIF("${CMAKE_BUILD_TYPE}" STREQUAL "MinSizeRel")
#   MESSAGE(STATUS "**** Maximum optimization for size ****")
# ELSE() # "Debug"
#   MESSAGE(STATUS "**** No optimization, debug info included ****")
# ENDIF()