CC = gcc
INCLUDES = -I/usr/include/mysql

# link libmysqlclient functions dynamically
LIBS =  -lmysqlclient

# link libmysqlclient functions statically
# LIBS =  -L/usr/lib/mysql/  -lmysqlclient -lz

all:prepare

main.o: main.c
	$(CC) -c $(INCLUDES)  main.c

prepare: main.o
	$(CC) -o prepare main.o $(LIBS)

clean:
	rm -f prepare main.o *~
