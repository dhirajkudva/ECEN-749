#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

int main() {
    unsigned int result;
    int fd;     // File descriptor 
    int i, j;   // Loop variables
    int buff[2];
    int read_buff[3];
    char input = 0;
    
    // Open device file for reading and writing 
    // Use 'open' to open '/dev/multiplier'
    fd = open("/dev/multiplier",O_RDWR);
    // Handle error opening file 
    if(fd == -1) {
        printf("Failed to open device file!\n");
        return -1;
    }
    
    for(i = 0; i <= 16; i++) {
        for(j = 0; j <= 16; j++) {
            // Write value to registers using char dev 
            // Use write to write i and j to peripheral 
            // Read i, j, and result using char dev
            // Use read to read from peripheral 
            // print unsigned ints to screen 
	    buff[0]=i;
	    buff[1]=j;
            write(fd,buff,8);
	    read(fd,read_buff,12);
            printf("%u * %u = %u\n\r", read_buff[0], read_buff[1], read_buff[2]);
                
            // Validate result 
            if(read_buff[2] == (i*j))
                printf("Result Correct!");
            else
                printf("Result Incorrect!");
                
            // Read from terminal 
            input = getchar();
            // Continue unless user entered 'q' 
            if(input == 'q') {
                close(fd);
                return 0;
            }
        }
    }
    close(fd);
    return 0;
}
