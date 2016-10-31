#include<unistd.h>
#include<stdio.h>
#include<dirent.h>
#include<string.h>
#include<sys/stat.h>
#include<stdlib.h>

void printdir(char *dir, int depth){
	DIR *dp;
	struct dirent *entry;
	struct stat statbuf;	
        /* 디렉토리 오픈 만약 NULL 이면 오픈x */
	if((dp = opendir(dir)) == NULL){ 
		fprintf(stderr, "cannot open directory: %s\n", dir);
		return;
	}

	chdir(dir); // 디렉토리 이동

	while((entry = readdir(dp)) != NULL){  // 엔트리 읽기
		lstat(entry->d_name, &statbuf); // 엔트리에 대한 정보 확인
		if(S_ISDIR(statbuf.st_mode)){  // 검색된 엔트리가 디렉토리이면
			/*디렉토리 찾기 성공, 이름비교하여 ‘.’과‘..’은 skip*/
			if(strcmp(".", entry->d_name) == 0 ||
				strcmp("..", entry->d_name) == 0) continue;                               /*디렉토리 이름의 시작이‘.’ 이면 skip*/
			if(entry->d_name[0] == '.') continue;
                        /*디렉토리명 출력*/
			printf("%*s%s\n", depth, "", entry->d_name);
			/*printdir함수 재귀호출 매개변수는 현재 entry*/
			printdir(entry->d_name, depth+4);
					}
		else{   // 검색된 엔트리가 파일
			if(entry->d_name[0] == '.') continue;//‘.’으로 시작하면 skip			printf("%*s%s\n", depth, "", entry->d_name);//파일명 출력
		}
	}
	chdir(".."); // 이전 디렉토리로 이동
	closedir(dp); // 디렉토리 스트림 해제
}
int main(){
	printf("File scan of present directory:\n");
	printdir(".", 0); // printdir 함수호출 매개변수는 현재 디렉토리
	printf("done.\n");
	exit(0);

}