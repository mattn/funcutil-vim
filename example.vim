let s:foo = {"x": 0}
function! s:foo.bar(a, b)
  let sum = a:a + a:b 
  let self.x += sum
  return sum
endfunction

function! s:ok(lhs, rhs)
  if a:lhs isnot# a:rhs
    throw "failed:".string(a:lhs).",".string(a:rhs)
  endif
  echo "ok"
endfunction

call s:ok(call(funcutil#ref('a:1 + a:2'), [1,2]), 3)
call s:ok(call(funcutil#ref('a:1 * a:2'), [2,3]), 6)
call s:ok(call(funcutil#ref('a:1 . a:2'), [2,3]), '23')

call s:ok(call(funcutil#ref(s:foo['bar'], s:foo), [2,3]), 5)
call s:ok(call(funcutil#ref(s:foo['bar'], s:foo), [2,3]), 5)
call s:ok(call(funcutil#ref(s:foo, 'bar'), [3,4]), 7)
call s:ok(call(funcutil#ref('a:1+a:2+__[0].x', s:foo), [3,4]), 24)
call s:ok(s:foo.x, 17)
