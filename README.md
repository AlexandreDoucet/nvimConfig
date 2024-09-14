Issues with c++ standard template not found by neovim

I had a similar issue on Pop!_OS 22.04 LTS using lunarvim 1.2 and Clang++/Clangd seems to look for the newest available libraries, so instead of parsing the "11" directory (which contained "libstdc++"), it parses the "12" directory (which did not contain "libstdc++") for the libraries.

ls /usr/lib/gcc/x86_64-linux-gnu/

11  12

I searched for the version I needed.

apt search libstdc++

Problem was solved after installing the "libstdc++" for gcc version 12 from the apt repository.

apt install libstdc++-12-dev
