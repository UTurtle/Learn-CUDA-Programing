CUDA_PATH := /usr
HOST_COMPILER ?= g++-10
NVCC=${CUDA_PATH}/bin/nvcc -ccbin ${HOST_COMPILER}
TARGET=aos soa

INCLUDES= -I${CUDA_PATH}/samples/common/inc
NVCC_FLAGS=-m64 -lineinfo

IS_CUDA_11:=${shell expr `$(NVCC) --version | grep compilation | grep -Eo -m 1 '[0-9]+.[0-9]' | head -1` \>= 11.0}

# Gencode argumentes
SMS = 35 37 50 52 60 61 70 75 86 86 86
ifeq "$(IS_CUDA_11)" "1"
SMS = 52 60 61 70 75 80 86 86 86
endif
$(foreach sm, ${SMS}, $(eval GENCODE_FLAGS += -gencode arch=compute_$(sm),code=sm_$(sm)))

all : ${TARGET}

aos: aos.cu
	${NVCC} ${INCLUDES} ${ALL_CCFLAGS} ${GENCODE_FLAGS} -o $@ $<

soa: soa.cu
	${NVCC} ${INCLUDES} ${ALL_CCFLAGS} ${GENCODE_FLAGS} -o $@ $<

clean:
	rm -f ${TARGET} 
