TARGET_GCC="g++-10"

find . -type f -name Makefile -print0 \
  | xargs -0 sed -i -E \
    -e 's|^CUDA_PATH=.*|CUDA_PATH := /usr|' \
    -e 's|^(\s*SMS = .*)( 86)?$|\1 86|' \
    -e "s|^(HOST_COMPILER\s*[?]?=).*|\1 ${TARGET_GCC}|"
