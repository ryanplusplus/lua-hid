all: luahidapi.so

CC       ?= gcc
CFLAGS   ?= -Wall -g -fpic
LDFLAGS  ?= -Wall -g

OBJS      = src/luahidapi.o lib/hidapi/linux/hid.o
LIBS      = `pkg-config libudev --libs` -lrt
INCLUDES ?= -Ilib/hidapi/hidapi -I$(HOME)/.lenv/current/include `pkg-config libusb-1.0 --cflags`

# Shared Libs
luahidapi.so: $(OBJS)
	$(CC) $(LDFLAGS) -shared -fpic -Wl,-soname,$@.0 $^ -o $@ $(LIBS)

# Objects
$(OBJS): %.o: %.c
	$(CC) $(CFLAGS) -c $(INCLUDES) $< -o $@

clean:
	rm -f $(OBJS) luahid.so

.PHONY: clean libs
