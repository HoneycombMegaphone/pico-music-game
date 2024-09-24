--beat

beat = {
	power = true,
	tempo = 30,
	sprite = 0,
	count = 30,
	reverb = 2,
	x = 62,
	y = 62,
	cooldown = 0,
	button = 5,
	sound = 0,

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
			self.sprite = 0
			if btnp(self.button) then
				if self.count <= 3 
					or self.count >= self.tempo - 3 then
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
		self.count = self.count - 1

		if self.count == 1 then
			self.y = self.y - 1
		elseif self.count == 0 then
			self.x = self.x - 1
			self.y = self.y + 3
			--sfx(beat.sound)
		elseif self.count < 0 then
			self.x = self.x + 1
			self.reverb = 1 
			self.count = self.tempo - 1
		end
		if self.reverb >= 0 then
			self.reverb = self.reverb - 1
			self.y = self.y - 1
		end
	end
}

beat1 = beat:new({x = 20, y = 20, button = 0})
beat2 = beat:new({x = 20, y = 40, button = 2})
beat3 = beat:new({x = 20, y = 60, button = 3})
beat4 = beat:new({x = 20, y = 80, button = 1})
