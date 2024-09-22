--main

beat1 = {}
beat1.power = true 
beat1.tempo = 30
beat1.sprite = 0
beat1.count = beat1.tempo
beat1.echo = 2
beat1.x = 73
beat1.y = 62

measure = {}
measure.count = 1
measure.size = 4

cooldown = 0

function _init()
	cls()
	beats={beat, beat2}
end

function _draw()
	cls()
	for beat in all(beats) do
		beat:draw()
		print('beat.count: ' ..beat.count)
	end
end

function _update()
	for beat in all(beats) do
		beat:update()
	end
end
