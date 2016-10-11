CC = gcc
INCLUDES = -I/usr/include/mysql

# link libmysqlclient functions dynamically
LIBS =  -lmysqlclient

# link libmysqlclient functions statically
# LIBS =  -L/usr/lib/mysql/  -lmysqlclient -lz

all:multi

main.o: main.c
	$(CC) -c $(INCLUDES)  main.c

multi: main.o
	$(CC) -o multi main.o $(LIBS)

clean:
	rm -f multi main.o *~
