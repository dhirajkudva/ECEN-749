#include <xparameters.h>
#include <xgpio.h>
#include <xstatus.h>
#include <xil_printf.h>

/* Definitions */
#define GPIO_DEVICE_ID XPAR_LED_DEVICE_ID   /* GPIO device that LEDs are connected to */
#define WAIT_VAL 0x1000000

int delay(void);

int main() {

    int count;
    int count_masked;
    XGpio leds;
    int status;

    status = XGpio_Initialize(&leds, GPIO_DEVICE_ID);
    XGpio_SetDataDirection(&leds, 1, 0x00);
    if(status != XST_SUCCESS) {
        xil_printf("Initialization failed");    
    }
    count = 0;
    while(1) {
        count_masked = count & 0xF;
        XGpio_DiscreteWrite(&leds, 1, count_masked);
        xil_printf("LEDs = 0x%x \n\r", count_masked);
        delay();
        count++;
    }
    return (0);
}

int delay(void) {
    volatile int delay_count = 0;
    while(delay_count < WAIT_VAL)
        delay_count++;
    return(0);
}

