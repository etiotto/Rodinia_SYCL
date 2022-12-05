VENDOR      = intel
OPTIMIZE    = yes
DEBUG       = no
DEVICE      = gpu


# Standard flags
override CFLAGS += -std=c++17 -Wall

# Linker flags
LDFLAGS = -lm

# Codeplay Compiler
ifneq (,$(findstring codeplay,$(VENDOR)))
  CC = compute++
  override CFLAGS += -no-serial-memop -sycl -sycl-driver
  LDFLAGS += -lComputeCpp
endif

# Intel DPC++ Compiler
ifneq (,$(findstring intel,$(VENDOR)))
  CC = dpcpp
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


all: kmeans

kmeans: cluster.o getopt.o read_input.o rmse.o kmeans.cpp
	$(CC) $(KERNEL_DIM) $(CFLAGS) $^ -o kmeans $(LDFLAGS)

%.o: %.[ch]
	$(CC) $(CFLAGS) $< -c

cluster.o: cluster.c kmeans.h
	$(CC) $(CFLAGS) cluster.c -c

getopt.o: getopt.c getopt.h
	$(CC) $(CFLAGS) getopt.c -c

read_input.o: read_input.c 
	$(CC) $(CFLAGS) read_input.c -c

rmse.o: rmse.c
	$(CC) $(CFLAGS) rmse.c -c

clean:
	rm -f *.o *~ kmeans *.linkinfo

run: kmeans
	./kmeans -o -i ../../data/kmeans/kdd_cup


