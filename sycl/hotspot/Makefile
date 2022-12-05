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
  override CFLAGS += -g  
endif

# Optimization Flags
ifeq ($(OPTIMIZE),yes)
  override CFLAGS += -O3
endif

ifeq ($(DEVICE),gpu)
  override CFLAGS +=-DUSE_GPU
endif



EXE = hotspot

$(EXE): hotspot.cpp hotspot.h kernel_hotspot.sycl
	$(CC) $(CFLAGS) -o $(EXE) hotspot.cpp $(LDFLAGS)

run: $(EXE)
	./$(EXE) 512 2 2 ../../data/hotspot/temp_512 ../../data/hotspot/power_512 output_512.out
	#./$(EXE) 64 2 2 ../../data/hotspot/temp_64 ../../data/hotspot/power_64 output_64.out

clean:
	rm -f $(EXE)
