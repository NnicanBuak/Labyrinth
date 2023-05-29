import 'app/utils/state'
import 'app/components/game/game'

class('GamePlayState', { name = 'game.play' }).extends(State)

function GamePlayState:entered()
	print('GamePlayState:entered')
	self.component = GameScene(self)
end

function GamePlayState:leaving()
	print('GamePlayState:leaving')
	if self.component then
		self.component.leaving(self.component)
	end
end

function GamePlayState:onSwitch(current, previous)

	print('GamePlayState:onSwitch')
	print('	current:', current)
	print('	previous:', previous)

	-- if (current == 'game.play' and current ~= previous) then
	if (current == 'game.play') then
		self:entered()
	elseif (current == 'main') then
		self:leaving()
	elseif (previous == 'game.play') then
		-- self:leaving()
	end

end
