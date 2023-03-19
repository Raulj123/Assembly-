#include<iostream>
#include <iomanip>
#include <stdio.h>
using namespace std;
extern "C" double asmFile();
int main(){
    double hypothenuse = 0.0;
    cout << "\nWelcome to Pythagoras’ Math Lab programmed by Raul Jarquin Valdez Please contact me at jarquinr121@csu.fullerton.edu if you need assistance.\n\n";
    hypothenuse = asmFile();
    cout << "\nThe main file received this number: " <<  setprecision(14) << fixed << hypothenuse << ", and will keep it for now We hoped you enjoyed your right angles. Have a good day. A zero will be sent to your operating system.\n\n";
    return 0;
}
