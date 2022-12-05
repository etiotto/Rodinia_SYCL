VENDOR      = intel
OPTIMIZE    = yes
DEBUG       = no
DEVICE      = gpu



# Standard flags (profiling is enabled to measure device offloading time)
override CFLAGS += -std=c++17 -Wall -DPROFILING

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

SRC = bfs.cpp timer.cc

EXE = bfs

$(EXE):$(SRC)
	$(CC) $(CFLAGS)   $(SRC) -o $(EXE)  $(LDFLAGS) 

run: $(EXE)
	./$(EXE) ../../data/bfs/graph1MW_6.txt
	#./$(EXE) ../../data/bfs/graph4096.txt
	#./$(EXE) ../../data/bfs/graph65536.txt


clean: 
	rm -f $(EXE) $(EXE).linkinfo result*
