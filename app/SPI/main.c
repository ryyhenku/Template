
#include "subsys_spi.h"
#include "stdio.h"
extern void board_init();

int main()
{
    // uint8_t test_buf[6] = {0x1,0x2,0x3,0x4,0x5,0x6};
    board_init();

    // spi_ops_t * spi2_ops =  spi_bus_ops_get_by_name("SPI2");
    // if( spi2_ops == NULL ) {
    //     return;
    // }



    // spi2_ops->pfn_spi_init();
    // spi2_ops->pfn_spi_cs_select();
    // spi2_ops->pfn_spi_write(test_buf,6);
    // spi2_ops->pfn_spi_cs_deselect();
    return 0;
}