import 'app/utils/event-emitter'

local gfx <const> = playdate.graphics
local sprite <const> = gfx.sprite

class('Gameplay').extends()

function Gameplay:init(game)
	self.game = game
	self.eventEmitter = EventEmitter:init()

	self.onGameoverHandler = function()
		self:gameover()
	end

	self.eventEmitter:on('game.over', self.onGameoverHandler)
end

function Gameplay:check()
	print('Gameplay:check')
end

function Gameplay:gameover()
	self.game:gameover()
	-- self.eventEmitter:emit('state.switch', 'game.over')
end

function Gameplay.leaving(instance)
	-- dump instances

	-- emit event
	instance.eventEmitter:off('game.over', instance.onGameoverHandler)
end
