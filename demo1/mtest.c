#include <stdio.h>
#include <stdlib.h>
extern InFoo(), InBoo(), InBar();

int main(int argc, char* argv[]){
	InFoo();
	InBoo();
	InBar();
	return 0;
}