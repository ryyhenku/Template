#ifndef __SSC_ADAPTER_H__
#define __SSC_ADAPTER_H__


#if SLAVE_CORE_IS_ET1100
#include "ET1100.h"
#endif

uint16_t HW_Init(void);
void HW_Release(void);



#endif /*__SSC_ADAPTER_H__*/