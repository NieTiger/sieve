function Sieve(size)
  if size < 2 then return {} end

  local a, q, factor = {}, math.floor(math.sqrt(size)), 3

  while factor < q do
    for num=factor,size,2 do
      if a[num] == nil then factor = num break end
    end

    for num=factor*factor,size,factor*2 do
      a[num] = 1
    end

    factor = factor + 2
  end

  local res = {2}
  for i=3,size,2 do
    if a[i] == nil then res[#res + 1] = i end
  end

  return res
end

function Load_truth()
  local truth = {}
  local raw = io.open("../truth.txt", "r"):read("*a")
  for v in string.gmatch(raw, "%S+") do
    truth[#truth + 1] = tonumber(v)
  end
  return truth
end

function Cmp_tbl(t1, t2)
  if #t1 ~= #t2 then return false end
  for i=1,#t1 do
    if t1[i] ~= t2[i] then return false end
  end
  return true
end

function Main()
  local res = Sieve(1000000) 
  local truth = Load_truth()
  if not Cmp_tbl(res, truth) then
    warn("Impl error.")
    return
  end


  local _end = os.clock() + 5
  local counter = 0
  while os.clock() < _end do
    Sieve(1000000)
    counter = counter + 1
  end
  print(counter)
end

Main()
