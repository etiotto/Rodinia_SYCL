VENDOR      = intel
OPTIMIZE    = yes
DEBUG       = no
DEVICE      = gpu
OUTPUT      = no



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

ifeq ($(OUTPUT),yes)
  override CFLAGS += -DBENCH_PRINT
endif

# Debug Flags
ifeq ($(DEBUG),yes)
  override CFLAGS += -g 
endif

# Optimization Flags
ifeq ($(OPTIMIZE),yes)
  override CFLAGS += -O3
endif

ifeq ($(DEVICE),gpu)
  override CFLAGS +=-DUSE_GPU
endif


# link objects(binaries) together
pathfinder: main.o 
	$(CC) main.o $(LDFLAGS) -o pathfinder

# compile main function file into object (binary)
main.o: main.cpp  kernel.sycl
	$(CC) $(CFLAGS) main.cpp -c -o main.o

run: pathfinder
	./pathfinder 100000 100 20

clean:
	@rm -f pathfinder *.o *.out *~ *\#
