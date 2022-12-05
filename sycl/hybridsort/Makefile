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
  override CFLAGS += -g -DDEBUG
endif

# Optimization Flags
ifeq ($(OPTIMIZE),yes)
  override CFLAGS += -O3
endif

ifeq ($(DEVICE),gpu)
  override CFLAGS +=-DUSE_GPU
endif


ifdef VERIFY
override VERIFY = -DVERIFY
endif

ifdef OUTPUT
override OUTPUT = -DOUTPUT
endif

ifdef TIMER
override TIMER = -DTIMER
endif

hybridsort: hybridsort.c bucketsort.o mergesort.o
	$(CC) $(CFLAGS) -o hybridsort $(VERIFY) $(OUTPUT) $(TIMER) \
		hybridsort.c bucketsort.o mergesort.o $(LDFLAGS)

bucketsort.o: bucketsort.c \
	kernel_bucketprefix.sycl \
	kernel_histogram.sycl \
	kernel_bucketcount.sycl \
       	kernel_bucketsort.sycl  
	$(CC) $(CFLAGS) -o bucketsort.o -c bucketsort.c 

mergesort.o: mergesort.c mergesort.h kernel_mergeSortPass.sycl
	$(CC) $(CFLAGS) -o mergesort.o -c mergesort.c 

run: hybridsort
	./hybridsort r

clean:
	rm -f  bucketsort.o mergesort.o hybridsort
