CC = gcc
INCLUDES = -I/usr/include/mysql 
# link libmysqlclient functions dynamically
LIBS =  -lmysqlclient
# link libmysqlclient functions statically
# LIBS =  -L/usr/lib/mysql -lmysqlclient -lz

all:blobtest

main.o: main.c
	$(CC) -c $(INCLUDES)  main.c

blobtest: main.o
	$(CC) -o blobtest main.o $(LIBS)

clean:
	rm -f blobtest main.o test-copy.jpg *~
