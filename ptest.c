#include <stdio.h>
#include <time.h>
#include <unistd.h>

int main(void)
{
	time_t rawtime;
	while(1){
		time(&rawtime);
		printf("ptest::local time = %s", ctime(&rawtime));
		sleep(2);
	}
	return -1;
}