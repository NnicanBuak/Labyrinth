import 'app/utils/table'
import 'app/utils/number'
import 'app/utils/string'
-- import 'app/utils/event-emitter'
import 'app/utils/state-manager'

import 'app/states/init'
import 'app/states/main'
import 'app/states/game/play'
import 'app/states/game/pause'
import 'app/states/game/over'



class('App').extends()

function App:init()

	print('App:init')

	self.appStorage = nil
	-- self.storage = {}


	-- First way
	self.stateManager = StateManager(InitState, MainState, GamePlayState, GamePauseState,GameOverState)


	-- Second way
	--[[
		self.stateManager = StateManager()
		self.stateManager:push(InitState:init(self.stateManager))
		self.stateManager:push(MainState:init(self.stateManager))
		self.stateManager:push(GameplayState:init(self.stateManager))
		self.stateManager:push(GameplayPauseState:init(self.stateManager))
		self.stateManager:push(GameoverState:init(self.stateManager))
		self.stateManager:push(AchievementsState:init(self.stateManager))
	]]--

	print('	app state manager:', self.stateManager)

end

function App:start()
	self.stateManager:switch('init')
end