
function distance ( x1, y1, x2, y2 )
  local dx = x1 - x2
  local dy = y1 - y2
  return math.sqrt ( dx * dx + dy * dy )
end

function sign(x)
	if x > 0 then
		return 1
	elseif x < 0 then 
		return -1
	else
		return 0
	end
end

function round(x)
	local floor = math.floor(x)
	if ((x - floor) >= 0.5) then 
		return math.ceil(x)
	else
		return floor
	end
end