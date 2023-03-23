//Name: Raul Jarquin Valdez
//Email: jarquinr121@csu.fullerton.edu
//Today's date:  03/22/23
//Section ID: Section 7, MW 12-2pm


#include<stdio.h>

extern void display_array(double ar[], int ar_size);

void display_array(double ar[], int ar_size){
    for(int i =0; i < ar_size; i++){
        printf("%lf\n",ar[i]);
    }
    printf("\n");
}