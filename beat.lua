--beat

beat = {
	power = true,
	note = 30, --default to beat
	deafult = 0,
	sprite = 0,
	count = 30,
	reverb = 2,
	x = 62,
	y = 62,
	cooldown = 0,
	button = 5,
	sound = 0,
	chart = {},
	new = function(self, table)
		table = table or {}
		setmetatable(table, {
			__index = self
		})
		return table
	end,

	draw = function(self)
		spr(self.sprite, self.x, self.y, 2, 2)
	end,

	update = function(self)
		if (self.cooldown == 0) then
			self.sprite = self.default
			if btnp(self.button) then
				if ceil(self.count) <= 3
					or flr(self.count) >= self.note - 2 then
					self.sprite = 2
				else
					self.sprite = 4
					self.cooldown = self.cooldown + 5
				end
				self.cooldown = self.cooldown + 2
			end
		else
			self.cooldown = self.cooldown - 1
		end

		if flr(self.count) == 2 then
			self.y = self.y - 1
		elseif flr(self.count) == 1 then
			self.x = self.x - 1
			self.y = self.y + 3
			--sfx(beat.sound)
		elseif flr(self.count) == 0 then
			self.x = self.x + 1
			self.reverb = 1 
			if self.chart == {} then
				self.count = self.count + 30
			else
				self.note = self.chart[1]
				deli(self.chart, 1)
				self.count = self.count + self.note
			end
		end
		if self.reverb >= 0 then
			self.reverb = self.reverb - 1
			self.y = self.y - 1
		end
		self.count = self.count - 1
	end,
	addRhythm = function(self, table)
		table = table or {}
		for notes in all(table) do
			add(self.chart, notes)
		end
	end
}

beat1 = beat:new({default = 32, x = 20, y = 20, button = 0, chart = {}})
beat2 = beat:new({default = 34, x = 20, y = 40, button = 2, chart = {}})
beat3 = beat:new({default = 36, x = 20, y = 60, button = 3, chart = {}})
beat4 = beat:new({default = 36, x = 20, y = 80, button = 1, chart = {}})
