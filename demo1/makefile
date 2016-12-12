mtest : mtest.o foo.o boo.o bar.o
	gcc -o mtest mtest.o foo.o boo.o bar.o

mtest.o : mtest.c
	gcc -g -c mtest.c

foo.o : foo.c
	gcc -g -c foo.c

boo.o : boo.c
	gcc -g -c boo.c

bar.o : bar.c
	gcc -g -c bar.c
