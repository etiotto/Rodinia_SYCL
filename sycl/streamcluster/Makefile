VENDOR      = intel
OPTIMIZE    = yes
DEBUG       = no
DEVICE      = gpu



# Standard flags
override CFLAGS += -std=c++17 -Wall #-DPROFILE_TMP

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

# Enable checksum and output file
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

SRC = streamcluster.cpp
EXE = streamcluster

$(EXE):$(SRC) kernel.sycl
	$(CC) $(CFLAGS) $(SRC) -o $(EXE) $(LDFLAGS)	

run: $(EXE)
	./$(EXE) 10 20 256 65536 65536 1000 none output.txt 1 

clean: 
	rm -f $(EXE) $(EXE).linkinfo result*
