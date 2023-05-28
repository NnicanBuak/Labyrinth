import 'app/utils/state'
import 'app/utils/storage'

class('InitState', { name = 'init' }).extends(State)

function InitState:entered()

	print('InitState:entered')

	if (not self.initialization) then

		-- local app <const> = APP
		-- app.appStorage = AppStorage()
		-- app.storage = app.appStorage:getData()

		self.initialization = true
	end

	-- Switch to `main` state
	self.manager:switch('main')
end


function InitState:onSwitch(current, previous)

	print('InitState:switch')
	print('	current:', current)
	print('	previous:', previous)

	if (current == 'init' and current ~= previous) then
		self:entered()
	end
end


