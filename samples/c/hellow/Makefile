CC = gcc
INCLUDES = -I/usr/include/mysql 

# link libmysqlclient functions dynamically
LIBS =  -lmysqlclient

# link libmysqlclient functions statically
# LIBS =  -L/usr/lib/mysql -lmysqlclient -lz

all:hellow

main.o: main.c
	$(CC) -c $(INCLUDES)  main.c

hellow: main.o
	$(CC) -o hellow main.o $(LIBS)

clean:
	rm -f hellow main.o *~
