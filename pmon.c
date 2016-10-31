#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
 /*pid값을 얻는 함수*/
int getPID(char *process_name){
        int pid = -1;
         char cmd_result[1024];
        FILE *fp;         

        sprintf(cmd_result,"ps -eaf | grep -w %s | grep -v grep | awk '{print $2}'",process_name); 
         fp = popen(cmd_result,"r");
        if(fp != NULL){
               fseek(fp,0,SEEK_SET);
               fscanf(fp,"%d",&pid);
 
               fclose(fp);
        } 
        return pid;
}
               
/*ptest 동작확인*/
void check_process(){
       int pid = getPID("ptest");
        if(pid == -1){
               printf("not existed\n");
        }else{
               printf("running\n");
        }
        alarm(5);
}
 /* 메인 */
int main(int argc,char* argv[]){
 
        char command=0;
        int pid;
        signal(SIGALRM,check_process);
        alarm(5);
 
        while(command != 'q'){
               printf(">>");
               scanf("%c",&command);
               while(getchar()!='\n'); 
               pid = getPID("ptest");
               switch(command){
                       case 'Q':
                       case 'q':
                              printf("프로그램 종료\n");
                              command='q';
                              break;
                       case 'K':
                       case 'k':
                              if(pid != -1){
                                      kill(pid,SIGKILL);
                              }else{
                                      printf("not existed\n");
                              }
                              break;
                       case 'S':
                       case 's':
                              if(pid != -1){
                                      printf("already running\n");
                               }else{
                                      system("./ptest &");
                              }
                              break;
                       case 'R':
                       case 'r':
                              if(pid != -1){
                                      kill(pid,SIGKILL);
                              }else{
                                      printf("newly started\n");
                              }
                              system("./ptest &");
               }
        }
} 