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
        /* ���丮 ���� ���� NULL �̸� ����x */
	if((dp = opendir(dir)) == NULL){ 
		fprintf(stderr, "cannot open directory: %s\n", dir);
		return;
	}

	chdir(dir); // ���丮 �̵�

	while((entry = readdir(dp)) != NULL){  // ��Ʈ�� �б�
		lstat(entry->d_name, &statbuf); // ��Ʈ���� ���� ���� Ȯ��
		if(S_ISDIR(statbuf.st_mode)){  // �˻��� ��Ʈ���� ���丮�̸�
			/*���丮 ã�� ����, �̸����Ͽ� ��.������..���� skip*/
			if(strcmp(".", entry->d_name) == 0 ||
				strcmp("..", entry->d_name) == 0) continue;                               /*���丮 �̸��� �����̡�.�� �̸� skip*/
			if(entry->d_name[0] == '.') continue;
                        /*���丮�� ���*/
			printf("%*s%s\n", depth, "", entry->d_name);
			/*printdir�Լ� ���ȣ�� �Ű������� ���� entry*/
			printdir(entry->d_name, depth+4);
					}
		else{   // �˻��� ��Ʈ���� ����
			if(entry->d_name[0] == '.') continue;//��.������ �����ϸ� skip			printf("%*s%s\n", depth, "", entry->d_name);//���ϸ� ���
		}
	}
	chdir(".."); // ���� ���丮�� �̵�
	closedir(dp); // ���丮 ��Ʈ�� ����
}
int main(){
	printf("File scan of present directory:\n");
	printdir(".", 0); // printdir �Լ�ȣ�� �Ű������� ���� ���丮
	printf("done.\n");
	exit(0);

}