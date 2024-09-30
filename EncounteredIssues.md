Issues with c++ standard template not found by neovim

I had a similar issue on Pop!_OS 22.04 LTS using lunarvim 1.2 and Clang++/Clangd seems to look for the newest available libraries, so instead of parsing the "11" directory (which contained "libstdc++"), it parses the "12" directory (which did not contain "libstdc++") for the libraries.

ls /usr/lib/gcc/x86_64-linux-gnu/

11  12

I searched for the version I needed.

apt search libstdc++

Problem was solved after installing the "libstdc++" for gcc version 12 from the apt repository.

apt install libstdc++-12-dev



Mason-nvim-dap

This pluging can autoinstall certain debugger, nicely it can be done using a common name but it is not intuitive on your first time. Use the lefts collumns of hte table bellow for autoinstall 

https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua


M.nvim_dap_to_package = {
	['python'] = 'debugpy',
	['cppdbg'] = 'cpptools',
	['delve'] = 'delve',
	['node2'] = 'node-debug2-adapter',
	['chrome'] = 'chrome-debug-adapter',
	['firefox'] = 'firefox-debug-adapter',
	['php'] = 'php-debug-adapter',
	['coreclr'] = 'netcoredbg',
	['js'] = 'js-debug-adapter',
	['codelldb'] = 'codelldb',
	['bash'] = 'bash-debug-adapter',
	['javadbg'] = 'java-debug-adapter',
	['javatest'] = 'java-test',
	['mock'] = 'mockdebug',
	['puppet'] = 'puppet-editor-services',
	['elixir'] = 'elixir-ls',
	['kotlin'] = 'kotlin-debug-adapter',
	['dart'] = 'dart-debug-adapter',
	['haskell'] = 'haskell-debug-adapter',
	['erlang'] = 'erlang-debugger',
}
