import 'app/utils/state'

class('GameOverState', { name = 'game.over' }).extends(State)

function GameOverState:entered()
	print('GameOverState:entered')
end

function GameOverState:leaving()
	print('GameOverState:leaving')
end

function GameOverState:onSwitch(current, previous)

	print('GameOverState:onSwitch')

	if (current == 'game.over' and current ~= previous) then
		self:entered()
	elseif (previous == 'game.over') then
		self:leaving()
	end

end
