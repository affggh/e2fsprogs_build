# e2fsprogs_build

## build on cygwin
### Install requirements
libc++-devel    
libc++abi-devel    
clang    
llvm    
gcc-core    
gcc-g++     

### Set CC and CXX env   
`export CC=clang`    
`export CXX=clang++`    

### Clone and compile
`git clone https://github.com/affggh/e2fsprogs_build --depth=1 --recurse-submodules`      
`cd e2fsprogs_build`    
`cmake -B build -G Ninja`    
`ninja -C build`    