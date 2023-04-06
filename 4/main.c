#include <stdio.h>
#include <string.h>

extern double manager();
int main(){
    double computation = manager();
    printf("\nThe main function has received this number %f and will keep it for future reference. The main function will return a zero to the operating system.", computation);
    return 0;
}