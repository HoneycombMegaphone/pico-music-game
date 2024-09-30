--main

clock = {
	tempo = 30, -- global beat
	count = 30,
	update = function(self)
		if self.count == 0 then self.count = clock.tempo end
		self.count = self.count - 1
	end
}

staff = {
	sprite = 6,
	x = 128,
	new = function(self, table)
		table = table or {}
		setmetatable(table, {
			__index = self
		})
		return table
	end,
	update = function(self)
		if self.x == 0 then	self.x = 120 end
		self.x = self.x - 1
	end,
	draw = function(self)
		for y = 20 + noteDist, 80 + noteDist, 20 do
			spr(self.sprite, self.x, y)
		end
	end
}

function _init()
	cls(1)
	noteDist = 4
	ongoing = false
	duration = 0 
	playSample = false
	beats = {beat1, beat2, beat3, beat4}
	sheet = {}
	for i = 0, 15 do
		if (i / 4 < 1) then
			add(sheet, staff:new({x = 113, sprite = 7}))
		elseif (i / 4 < 2) then
			add(sheet, staff:new({x = 83, sprite = 7}))
		elseif (i / 4 < 3) then
			add(sheet, staff:new({x = 53, sprite = 7}))
		else
			add(sheet, staff:new({x = 23, sprite = 8}))
		end
	end
end

function _draw()
	cls(1)
	print("Use Arrow keys to tap to beat")
	print("To Play Sample, hit Z")
	for x = 0, 120, 8 do
		for y = 20 + noteDist, 80 + noteDist, 20 do
			spr(6, x, y)
		end
	end
	for staff in all(sheet) do
		staff:draw()
	end
	for beat in all(beats) do
		beat:draw()
	end
end

function _update()
	clock:update()
	for beat in all(beats) do
		beat:update()
	end
	for staff in all(sheet) do
		staff:update()
	end
	if btnp(4) and ongoing == false then playSample = true end
	if clock.count == 1 and ongoing == false and playSample == true then 
		addSample() 
	end
	if duration > 0 and clock.count == 1 then
		duration -= 1
		if duration == 0 then 
			for beat in all(beats) do
				beat.count = clock.count
			end
			ongoing = false 
		end
	end
end

function addSample()
	beat1:addRhythm({30, 15, 15, 30, 30})
	beat1:addRhythm({30, 30, 30, 30})
	beat2:addRhythm({15, 15, 15, 15, 30, 30})
	beat2:addRhythm({30, 15, 15, 15, 30, 15})
	beat3:addRhythm({15, 15, 15, 15, 15, 15, 15, 15})
	beat3:addRhythm({15, 15, 15, 15, 15, 15, 15, 15})
	beat4:addRhythm({7.5, 15, 15, 15, 15, 15, 15, 15})
	beat4:addRhythm({15, 15, 15, 15, 15, 15, 15})
	music(0)
	ongoing = true
	playSample = false
	duration = 9
end
