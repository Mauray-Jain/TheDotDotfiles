" This is mostly copied from the vim runtime files with some modifications
if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal indentexpr=s:getAsmIndent()
"setlocal indentkeys=<:>,!^F,o,O

"let b:undo_indent = "setlocal indentexpr< indentkeys<"

function! s:getAsmIndent()
  let l:prevlnum = prevnonblank(v:lnum-1)
  if l:prevlnum == 0
    " top of file
    return 0
  endif

	let l:line = getline(v:lnum)
	let l:prevline = getline(l:prevlnum)
  let l:ind = indent(l:prevlnum)

	" If prevline is a label then indent
	if prevline =~ '^\s*\k\+:'
		let l:ind += shiftwidth()
	endif

  " If the line is a label (starts with ':' terminated keyword), 
  " then don't indent
  if line =~ '^\s*\k\+:'
    let l:ind = 0
  endif

  return l:ind
endfunction
