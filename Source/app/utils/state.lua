class('State', { name = 'no.name.state', component = nil }).extends()

function State:init(stateManager)

	print('State:init')
	print('	name:', self.name)

	self.manager = stateManager

	return self.name, self
end

function State:entered()
	print('State:entered')
end

function State:leaving()
	print('State:leaving')
end

function State:revealed()
	print('State:revealed')
end

function State:obscuring()
	print('State:obsucring')
end

function State:onSwitch(current, previous)
	print('State:onSwitch')
end