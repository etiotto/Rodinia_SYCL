VENDOR      = intel
OPTIMIZE    = yes
DEBUG       = no
DEVICE      = gpu



# Standard flags
override CFLAGS += -I./common -std=c++17 -Wall

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

EXE = lud

$(EXE): lud.cpp ./common/common.c ./common/common.h \
	kernel_lud_diagonal.sycl \
	kernel_lud_internal.sycl \
       	kernel_lud_perimeter.sycl
	$(CC) $(KERNEL_DIM) $(CFLAGS) -o $(EXE) lud.cpp ./common/common.c $(LDFLAGS)

run: $(EXE)
	./$(EXE) -s 2048 -v

clean:
	rm -f $(EXE)
