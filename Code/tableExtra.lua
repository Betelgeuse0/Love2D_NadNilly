
function tableClear(t)
	for k,v in pairs(t) do
		t[k] = nil
	end
end

function tableFindIf(t, predicate)
	for i,v in ipairs(t) do
		if predicate(v) then 
			return v
		end
	end
	return nil
end

function tableForEach(t, func)
	for i,v in ipairs(t) do 
		func(v)
	end
end

function tableInsertContents(t, t2)
	for i,v in ipairs(t2) do
		table.insert(t, v)
	end
end

function tableRandomized(t)
	local randomized = {}

	for i = 1, #t do
		local index = math.random(1, #t)
		table.insert(randomized, t[index])
		table.remove(t, index)
	end

	return randomized 
end