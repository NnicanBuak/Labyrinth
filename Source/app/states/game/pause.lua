import 'app/utils/state'

class('GamePauseState', { name = 'game.pause' }).extends(State)

function GamePauseState:entered()
	print('GamePauseState:entered')
end

function GamePauseState:leaving()
	print('GamePauseState:leaving')
end


function GamePauseState:onSwitch(current, previous)

	print('GamePauseState:onSwitch')

	if (current == 'game.pause' and current ~= previous) then
		self:entered()
	elseif (previous == 'game.pause') then
		self:leaving()
	end

end