# e2fsprogs_build

## build on cygwin
### Download the clang for cygwin
Download [link](https://github.com/affggh/llvm-project/releases/download/clang18/clang18.0.0-cygwin64.tar.gz)    
```sh
mkdir $HOME/clang
cd $HOME/clang
# copy clang18.0.0-cygwin64.tar.gz here then

tar -xvf clang18.0.0-cygwin64.tar.gz
```
### Set CC and CXX env
`export PATH=$HOME/clang/bin:$PATH`    
`export CC=clang`    
`export CXX=clang++`    

### Clone and compile
`git clone https://github.com/affggh/e2fsprogs_build --depth=1 --recurse-submodules`    
`cd e2fsprogs_build`
`cmake -B build -G Ninja`
`ninja -C build`    