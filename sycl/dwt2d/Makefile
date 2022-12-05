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
  override CFLAGS += -g -DOUTPUT -DDEBUG
endif

# Optimization Flags
ifeq ($(OPTIMIZE),yes)
  override CFLAGS += -O3
endif

ifeq ($(DEVICE),gpu)
  override CFLAGS +=-DUSE_GPU
endif


dwt2d: main.cpp \
       kernel_CopySrcToComponent.sycl \
       kernel_CopySrcToComponents.sycl \
       kernel_fdwt53.sycl
	$(CC) $(CFLAGS) -o dwt2d \
		main.cpp \
		$(LDFLAGS)
		
run: dwt2d
	./dwt2d 192.bmp -d 192x192 -f -5 -l 3
	./dwt2d rgb.bmp -d 1024x1024 -f -5 -l 3

clean:	
	rm -rf *.o dwt2d
	rm -rf *.bmp.dwt.*

