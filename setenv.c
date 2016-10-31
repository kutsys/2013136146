#include <stdio.h> 
#include <stdlib.h> 

int main(){ 
	setenv("TEST_ENV", "1234", 1); 
	printf("%s: %s\n","TEST_ENV", getenv("TEST_ENV")); 
	return 0; 
} 