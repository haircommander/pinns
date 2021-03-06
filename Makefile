PKG_CONFIG ?= pkg-config
src = $(wildcard src/*.c)
obj = $(src:.c=.o)

override LIBS += $(shell $(PKG_CONFIG) --libs glib-2.0)
CFLAGS ?= -std=c99 -Os -Wall -Werror -Wextra
override CFLAGS += -static $(shell $(PKG_CONFIG) --cflags glib-2.0) 

all: bin/pinns

bin/pinns: $(obj)
	$(CC) $(LDFLAGS) -o $@ $^ $(LIBS)
	strip -s $@

%.o: %.c $(HEADERS)
	$(CC) $(CFLAGS) -o $@ -c $<


bin:
	mkdir -p $@

.PHONY: clean
clean:
	rm -f $(obj) bin/pinns
