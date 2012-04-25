if exists("g:loaded_nerdtree_git_nerd")
  finish
endif
let g:loaded_nerdtree_git_nerd=1
let g:NERDTreePrefix=1
let g:NERDTreeBeforeRender=1


function plugin:NERDTreeBeforeRender()
    let s:git_cached_status = ''
endfunction

function plugin:NERDTreePrefix(path)

  if !exists('s:git_cached_status') || s:git_cached_status == ''
    echomsg "Resetting the cached status"
    let s:git_cached_status = system("git status")
  endif

  let s:path_position = stridx(s:git_cached_status, a:path.cachedDisplayString)
  if(s:path_position > 0)
    
    let s:git_staged_position = stridx(s:git_cached_status, "Changes to be committed")
    let s:git_unstaged_position = stridx(s:git_cached_status, "Changes not staged for commit")

    if(s:path_position < s:git_unstaged_position)
      return "*"
    endif

    return "+"
  endif

  return ""
endfunction
