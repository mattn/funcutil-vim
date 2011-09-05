let s:foo = {"x": 0}
function! s:foo.bar(a, b)
  let sum = a:a + a:b 
  let self.x += sum
  return sum
endfunction

echo call(funcutil#ref('a:1 + a:2'), [1,2])
echo call(funcutil#ref('a:1 * a:2'), [2,3])
echo call(funcutil#ref('a:1 . a:2'), [2,3])

echo call(funcutil#ref(s:foo['bar'], s:foo), [2,3])
echo call(funcutil#ref(s:foo['bar'], s:foo), [2,3])
echo call(funcutil#ref(s:foo, 'bar'), [3,4])
echo s:foo.x
