# frozen_string_literal: true

a = 0
b = 1
fib = []
while b <= 100
  fib.push(b)
  a, b = b, a + b
end
