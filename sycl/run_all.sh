#!/bin/bash

run() {
	export LD_LIBRARY_PATH=/rdrive/ref/opencl/runtime/linux/oclcpu/2022.14.8.0.04/intel64_lin:/rdrive/ref/mkl/lin/xmain/20220707/lib:/rdrive/ref/tbb/lin/2021.7.0.3128/lib/intel64/gcc4.8:~/projects/intel-llvm/build/lib

	for (( i = 0; i < 10; i++ ))
	do
	  make run
	  [ $? -ne 0 ] && break 
	done
}

COMPILER="/iusers/etiotto/intel-llvm/build/bin/clang++"	

run_sycl () {
  FLAGS="-w -fsycl -fsycl-targets=spir64-unknown-unknown "

	make clean
  make OPTIMIZE=yes DEVICE=cpu CC=${COMPILER} CFLAGS+="${FLAGS}" 
  [ $? -eq 0 ] &&	run
}

run_sycl_mlir () {
  FLAGS="-w -fsycl -fsycl-targets=spir64-unknown-unknown-syclmlir "

	make clean
  make OPTIMIZE=yes DEVICE=cpu CC=${COMPILER} CFLAGS+="${FLAGS}" 
  [ $? -eq 0 ] &&	run
}

# The list of directories
### backprop  bfs  b+tree  cfd  dwt2d  gaussian  heartwall  hotspot  hotspot3D  huffman  
### hybridsort  kmeans  lavaMD  leukocyte  lud  myocyte  nn  nw  particlefilter  pathfinder  
### srad  streamcluster

MISSING_DATA="dwt2d heartwall hotspot hotspot3D kmeans leukocyte" # Bmks 
BROKEN="bfs b+tree cfd nn nw huffman lavaMD srad myocite pathfinder" 
SEGFAULTS="hybridsort"

OK_WITH_CLANG="backprop gaussian particlefilter streamcluster lud" 
OK_WITH_CGEIST="gaussian"

WORKLOADS=${OK_WITH_CGEIST}

for dir in ${WORKLOADS}
do
	cd ${dir}
	echo "######## Start ${dir} #########"
	#run_sycl
	run_sycl_mlir
	echo "######## Finish ${dir} #########"
	cd ..
done
