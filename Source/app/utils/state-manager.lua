import 'app/utils/event-emitter'

class('StateManager').extends()

function StateManager:init(...)

	print('StateManager:init')

	self.states = {}
	self.previous = ''
	self.current = ''

	local arg <const> = {...}

	if (arg) then
		for _, state in pairs(arg) do
			self:push(state:init(self))
		end
	end

	self.eventEmitter = EventEmitter:init()

	self.eventEmitter:on('state.switch', function(state)
		self:switch(state)
	end)

end


-- function StateManager:peek()
-- 	return self.states[self.current]
-- end


function StateManager:push(name, state)

	print('StateManager:push', name, state)

	if (name and state) then
		self.states[name] = state
	end
end


function StateManager:switch(current)

	print('StateManager:switch ', self.previous, '>', current)

	self.current = current
	local previous <const> = self.previous

	-- Update states, w/o current

	for key, item in pairs(self.states) do
		if(key ~= current) then
			item:onSwitch(current, previous)
		end
	end

	-- Update current state
	-- Very important: update self.previous before fire event
	self.previous = current

	self.states[current]:onSwitch(current, previous)

end