//Name: Raul Jarquin Valdez
//Email: jarquinr121@csu.fullerton.edu
//Today's date:  05/15/23
//Section ID: Section 07, MW 12-2pm

#include<stdio.h>

extern double manager();     //CHANGE
int main(){
    
    printf("\nWelcome to o Electric Circuits programmed by Raul Jarquin Valdez\n\n");  //CHANGE
    double voltage = manager(); //CHANGE
    printf("\nThe main program received %f and will keep it.  A zero will be sent to the OS.\n\n",voltage);  //CHANGE
    return 0;
}
