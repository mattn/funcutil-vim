if !exists('s:lambda')
  let s:lambda = {'n':0, 'f':{}}
endif

function! s:SID()
  return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
endfun

let s:sid = s:SID()

function! funcutil#ref(f, ...)
  if type(a:f) == 1
    if has_key(s:lambda.f, a:f)
      return s:lambda.f[f]
    else
      let s:lambda.n += 1
      let s:lambda_ff{s:lambda.n}_ = a:f
      function! s:lambda_ff{s:lambda.n}(...)
        return eval(eval(substitute(expand('<sfile>'), '^[^_]\+_', 's:', '').'_'))
      endfunction
      return function('<SNR>'.s:sid.'_lambda_ff'.(s:lambda.n))
    endif
  elseif type(a:f) == 2 && len(a:000) == 1
    let f = matchstr(string(a:f), '''\zs\d\+\ze')
    if exists('*s:lambda_f'.f)
      return function('<SNR>'.s:sid.'_lambda_f'.f)
    endif
    let s:lambda_f{f}_ = a:f
    let s:lambda_f{f}__ = a:000
    function! s:lambda_f{f}(...)
      return call(eval(substitute(expand('<sfile>'), '^[^_]\+_', 's:', '').'_'), a:000, eval(substitute(expand('<sfile>'), '^[^_]\+_', 's:', '').'__')[0])
    endfunction
    return function('<SNR>'.s:sid.'_lambda_f'.f)
  elseif type(a:f) == 4 && len(a:000) == 1
    return funcutil#ref(a:f[a:000[0]], a:f)
  endif
  return a:f
endfunction
