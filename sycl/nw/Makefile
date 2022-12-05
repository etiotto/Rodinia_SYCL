VENDOR      = intel
OPTIMIZE    = yes
DEBUG       = no
DEVICE      = gpu



# Standard flags
override CFLAGS += -std=c++17 -Wall

# Linker flags
LDFLAGS = 

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
  override CFLAGS += -g  
endif

# Optimization Flags
ifeq ($(OPTIMIZE),yes)
  override CFLAGS += -O3
endif

ifeq ($(DEVICE),gpu)
  override CFLAGS +=-DUSE_GPU
endif



SRC = nw.c

EXE = nw

$(EXE) : $(SRC) kernel1.sycl kernel2.sycl
	$(CC) $(CFLAGS) $(SRC) -o $(EXE) $(LDFLAGS) 

run: $(EXE)
	./nw 2048 10

clean: 
	rm -f $(EXE) 
