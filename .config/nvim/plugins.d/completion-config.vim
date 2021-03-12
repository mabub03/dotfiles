" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
" set shortmess+=c

let g:completion_enable_auto_popup = 1
" keybind to complete manually
imap <silent> <c-p> <Plug>(compeltion_trigger)

" possible value: 'UltiSnips', 'Neosnippet', 'vim-vsnip', 'snippets.nvim'
" let g:completion_enable_snippet = 'UltiSnips'  " disable by defualt

" automatically enabled to disable uncomment
" let g:completion_enable_auto_hover = 0
" let g:completion enable_auto_signature = 0
"
" possible value: 'length', 'alphabet', 'none'
let g:completion_sorting = "none"

" priotity list of matching strategies 
" options include 'exact', 'substring', 'fuzzy', and 'all'
" let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy', 'all']

" enable ignore case matching
" g:completion_matching_ignore_case = 1

" enable smart case matching
" g:completion_matching_smart_case = 1

" trigger characters (trigger characters of language server are respected by
" default)
" To add more trigger characters add by
" let g:completion_trigger_character = ['.', '::']

" specify keyword length for triggering completion by default it is 1
let g:completion_trigger_keyword_length = 3

" enable trigger completion on delete
" let g:completion_trigger_on_delete = 1

" uses timer to control rate of completion
let g:completion_timer_cycle = 80 "default value is 80 and github example is 200

