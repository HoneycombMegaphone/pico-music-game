--main

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
		self.x = self.x - 32/30
		if (self.x <= 0) then
			self.x = 128 - self.x
		end
	end,
	draw = function(self)
		for y = 20 + noteDist, 80 + noteDist, 20 do
			spr(self.sprite, self.x, y)
		end
	end
}

noteDist = 4

function _init()
	cls()
	beats = {beat1, beat2, beat3, beat4}
	--sheet = {measure, staff2, staff3, staff4}
	sheet = {}
	for i = 0, 15 do
		if (i / 4 < 1) then
			add(sheet, staff:new({x = 116, sprite = 7}))
		elseif (i / 4 < 2) then
			add(sheet, staff:new({x = 84, sprite = 7}))
		elseif (i / 4 < 3) then
			add(sheet, staff:new({x = 52, sprite = 7}))
		else
			add(sheet, staff:new({x = 20, sprite = 8}))
		end
	end
	music(0)
end

function _draw()
	cls()
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
		--print('beat.count: ' ..beat.count)
	end
end

function _update()
	for beat in all(beats) do
		beat:update()
	end
	for staff in all(sheet) do
		staff:update()
	end
end
