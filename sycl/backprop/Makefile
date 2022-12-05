VENDOR = intel
OPTIMIZE = yes
DEBUG = no
DEVICE = gpu

# Standard flags
override CFLAGS += -std=c++17 -Wall

# Linker flags
LDFLAGS = -lm

# Codeplay Compiler
ifneq (,$(findstring codeplay,$(VENDOR)))
  override CFLAGS += -no-serial-memop -sycl -sycl-driver
  LDFLAGS += -lComputeCpp
endif

# Intel DPC++ Compiler
ifneq (,$(findstring intel,$(VENDOR)))
  override CFLAGS += 
  LDFLAGS += 
endif

# Debug Flags
ifeq ($(DEBUG),yes)
  override CFLAGS += -g  -DOUTPUT
endif

# Optimization Flags
ifeq ($(OPTIMIZE),yes)
  override CFLAGS += -O3
endif

ifeq ($(DEVICE),gpu)
  override CFLAGS +=-DUSE_GPU
endif


backprop: backprop_sycl.o backprop.o imagenet.o facetrain.o
	$(CC) $(CFLAGS) backprop_sycl.o backprop.o imagenet.o facetrain.o -o backprop $(LDFLAGS)

%.o: %.[ch]
	$(CC) $(CFLAGS) $< -c

backprop_sycl.o: backprop_sycl.cpp bpnn_adjust_weights.sycl  bpnn_layerforward.sycl
	$(CC) $(CFLAGS) backprop_sycl.cpp -c
	
backprop.o: backprop.c 
	$(CC) $(CFLAGS) backprop.c -c
	
facetrain.o: facetrain.c
	$(CC) $(CFLAGS) facetrain.c -c

imagenet.o: imagenet.c
	$(CC) $(CFLAGS) imagenet.c -c

run: backprop
	./backprop 65536

clean:
	rm -f *.o *~ backprop *.linkinfo
