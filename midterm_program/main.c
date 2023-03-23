//Name: Raul Jarquin Valdez
//Email: jarquinr121@csu.fullerton.edu
//Today's date:  03/22/23
//Section ID: Section 7, MW 12-2pm

#include<stdio.h>

extern char* manager();
int main(){
    
    printf("\nWelcome to the Great Reverse by Raul Jarquin Valdez\n\n");
    char* name = manager();
    printf("\nGood-bye %s Have a nice weekend.  Zero will be returned to the operating system.Bye\n\n",name);
    return 0;
}