let [plugins, ftplugin] = dein#load_cache_raw(['/home/isomoto/.vimrc', '/home/isomoto/.dein.toml'], 1)
if empty(plugins) | throw 'Cache loading error' | endif
let g:dein#_plugins = plugins
let g:dein#_ftplugin = ftplugin
let g:dein#_base_path = '/home/isomoto/.vim/dein'
let g:dein#_runtime_path = '/home/isomoto/.vim/dein/.dein'
let &runtimepath = '/home/isomoto/.vim/dein/repos/github.com/Shougo/dein.vim,/home/isomoto/.vim,/var/lib/vim/addons,/home/isomoto/.vim/dein/.dein,/usr/share/vim/vimfiles,/usr/share/vim/vim74,/usr/share/vim/vimfiles/after,/var/lib/vim/addons/after,/home/isomoto/.vim/after,/home/isomoto/.vim/dein/.dein/after'
filetype off
