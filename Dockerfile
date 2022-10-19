FROM quay.io/pypa/manylinux_2_28_x86_64

RUN cd /root && dnf update -y && dnf install ninja-build -y \
    && git clone https://github.com/llvm/llvm-project.git  \
    && cd llvm-project && git checkout llvmorg-14.0.6 \
    && mkdir build && cd build  \
    && cmake -DCMAKE_CXX_FLAGS='-static-libgcc' \
    -DCMAKE_EXE_LINKER_FLAGS='-static-libgcc' \
    -DCMAKE_SHARED_LINKER_FLAGS='-static-libgcc'  ../llvm \
    -DCMAKE_INSTALL_PREFIX=/opt -DCMAKE_BUILD_TYPE=Release \
    -DLLVM_TARGETS_TO_BUILD=X86 -DLLVM_ENABLE_PROJECTS=clang \
    -DLLVM_ENABLE_ZLIB=OFF -DLLVM_STATIC_LINK_CXX_STDLIB=ON -G Ninja  \
    && ninja install \
    && cd /root \
    && rm -rf *
