#include <iostream>
using namespace std;
extern "C" int manager();
int main(){
    int age = 0;
    cout<< "welcome to my happpy birthday program! \n";
    age = manager();
    cout << age;
    return 0;
}