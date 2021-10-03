let g:VIM_HOME = expand('~/.config/nvim')

" 配置所在根目录
let g:config_root_path = g:VIM_HOME . '/config'
" vim插件安装目录
let g:plugins_path = g:VIM_HOME . '/plugged'
" coc插件安装目录
let g:coc_data_home = g:VIM_HOME . '/coc'
" 插件配置文件所在路径
let s:plugin_config_home = g:config_root_path . '/plugins'
" 自定义配置路径
let s:custom_config_home = g:config_root_path . '/custom'

" 自动安装Vim-Plug
let s:vim_plug_path = g:VIM_HOME.'/autoload/plug.vim'
if !filereadable(s:vim_plug_path)
	echo "Installing Vim-plug ..."
	echo ""
	let s:vim_plug_git = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	execute "!curl -fLo ".s:vim_plug_path." --create-dirs ".s:vim_plug_git
endif

" 定义载入配置命令
command! -nargs=1 LoadScript exec 'source ' . g:config_root_path . '/' . '<args>'

" 插件
call plug#begin(g:plugins_path)
LoadScript plug.vim
call plug#end()

" 判断插件是否载入
func! PlugLoaded(name)
    return (
        \ has_key(g:plugs, a:name) &&
        \ isdirectory(g:plugs[a:name].dir) &&
        \ stridx(&rtp, g:plugs[a:name].dir) >= 0)
endfunction

" 判断插件列表中是否含有某个插件
func! g:HasPlug(plugName) abort
    return (index(g:plugs_order, a:plugName) > -1 ? v:true : v:false)
    " if index(g:plugs_order, a:plugName) > -1 | return v:true
    " else | return v:false | endif
endfunction

" 判断该插件是否已经安装
func! g:HasInstall(plugin_name) abort
    let l:plugin_path = g:plugins_path . "/" . a:plugin_name
    " if !empty(glob(l:plugin_path)) | return v:true
    if isdirectory(l:plugin_path) | return v:true
    else | return v:false | endif
endfunction

" 判断是否安装了coc插件
func! g:HasCocPlug(cocPlugName)
    if g:HasPlug('coc.nvim') && index(g:coc_global_extensions, a:cocPlugName) > -1 | return v:true
    else | return v:false | endif
endfunc

" 自动安装插件
func! s:is_need_install()
	for l:plug_name in g:plugs_order
		let l:plug_path = g:plugins_path.'/'.l:plug_name
		if !isdirectory(l:plug_path)
			return 1
		endif
    endfor
endfunction

for s:plugin_name in g:plugs_order
    " 如果已经安装了插件，那么载入插件配置
    if g:HasInstall(s:plugin_name)
        "echo s:plugin_name
        let s:config_path = s:plugin_config_home . "/" . s:plugin_name . ".vim"
        if filereadable(s:config_path)
            "echo s:config_path
            exec 'source' fnameescape(s:config_path)
        endif
    endif
endfor

" 载入custom目录下的自定义配置
let s:custom_files = split(glob(s:custom_config_home . '/*.vim'), '\n')
for s:custom_file in s:custom_files
    exec 'source ' . fnameescape(s:custom_file)
endfor

if s:is_need_install()
	echom "Found new plugin(s) need to install."
	:PlugInstall
endif

" 加载基础配置
LoadScript base.vim
" 加载按键映射配置
LoadScript keymap.vim
" 加载主题配置
LoadScript theme.vim
