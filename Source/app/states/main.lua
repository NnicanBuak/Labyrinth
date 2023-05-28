import 'app/utils/state'
import 'app/components/main/main'

class('MainState', { name = 'main' }).extends(State)

function MainState:entered()
	print('MainState:entered')
	self.component = MainScene(self)
end

function MainState:leaving()
	print('MainState:leaving')
	self.component.leaving(self.component)
end

function MainState:onSwitch(current, previous)

	print('MainState:switch')
	print('	current:', current)
	print('	previous:', previous)

	if (current == 'main' and current ~= previous) then
		self:entered()
	elseif (previous == 'main') then
		self:leaving()
	end

end
