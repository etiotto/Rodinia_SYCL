VENDOR      = intel
OPTIMIZE    = yes
DEBUG       = no
DEVICE      = gpu
DUMP        = yes



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

ifeq ($(DUMP),yes)
  override CFLAGS += -DOUTPUT
endif

SRC = euler3d.cpp
EXE = euler3d

$(EXE):$(SRC) kernel_compute_flux.sycl  \
               kernel_compute_step_factor.sycl  \
	       kernel_initialize_variables.sycl \
	       kernel_memset.sycl \
	       kernel_time_step.sycl
	$(CC) $(CFLAGS) $(KERNEL_DIM) $(SRC) -o $(EXE) $(LDFLAGS)

run: $(EXE)
	./euler3d ../../data/cfd/fvcorr.domn.097K 
	#./euler3d ../../data/cfd/fvcorr.domn.193K   
	#./euler3d ../../data/cfd/missile.domn.0.2M  


clean: 
	rm -f $(EXE) $(EXE).linkinfo result*  density momentum density_energy
