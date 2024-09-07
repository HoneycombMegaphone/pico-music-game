beat = {}
beat.power = false
beat.tempo = 30
beat.sprite = 0
beat.count = beat.tempo
beat.echo = 2
beat.x = 61
beat.y = 61

measure = {}
measure.count = 4

cooldown = 0

function _init()
	cls()
end

function _draw()
	cls()
	if beat.power == true then
		print(60 - (beat.tempo * 2 - 60))
		spr(beat.sprite, beat.x, beat.y, 2, 2)
	end
end
function _update()
	if beat.echo ~= 0 then
		beat.echo = beat.echo -1
		if beat.echo == 0 then
			beat.y = beat.y - 1
		end
	end
	--buttons
	if btnp(4) then beat.power = not beat.power end
	if btnp(0) then beat.tempo = beat.tempo + 1 end
	if btnp(1) then beat.tempo = beat.tempo - 1 end
	if (btnp(2)) then beat.tempo = beat.tempo - 10 end
	if (btnp(3)) then beat.tempo = beat.tempo + 10 end
	if beat.tempo >= 45 then beat.tempo = 45 end
	if beat.tempo <= 5 then beat.tempo = 5 end
	if (cooldown == 0) then
		beat.sprite = 0
		if btnp(5) then
			if beat.count <= 3 or beat.count >= beat.tempo - 3 then
				beat.sprite = 2
			else
				beat.sprite = 4
				cooldown += 5
			end
			cooldown += 2
		end
	else
		cooldown = cooldown - 1
	end
	beat.count = beat.count - 1
	if beat.count == 1 then
		beat.y = beat.y - 1
	end
	if beat.count == 0 then
		beat.x = beat.x - 1
		beat.y = beat.y + 3
		measure.count = measure.count - 1
		if measure.count == 0 then
			-- measure indicator here
			measure.count = 4
		end
	end
	if beat.count < 0 then
		beat.x = beat.x + 1
		beat.y = beat.y - 1
		beat.echo = 2
		beat.count = beat.tempo - 1
	end
end
