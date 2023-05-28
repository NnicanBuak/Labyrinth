import 'app/utils/event-emitter'
import 'app/components/game/gameplay/gameplay'
import 'app/components/game/gameover/gameover'
import 'app/components/game/ui/score-bar'

local gfx <const> = playdate.graphics
local sprite <const> = gfx.sprite
local pushInputHandlers <const> = playdate.inputHandlers.push

class('GameScene').extends()

function GameScene:init(state)

	-- self.gameSettings = GameSettings()
	-- self.settings = self.gameSettings.data

	self.state = state


	self.inputHandlers = {
		gameplay = {
			AButtonUp =  function()
				self.gameplay:check()
			end,
		},
		gameover = {
			BButtonUp =  function()
			end,
			AButtonUp =  function()
			end,
		},
		gameover_revealed = {
			BButtonUp =  function()
				-- back to the main screen
				self.state.manager:switch('main')
			end,
			AButtonUp =  function()
				self.restart(self)
			end,
		},
	}

	self:initInputHandlers('gameplay')
	self:draw()

	print('	scoreBar', self.scoreBar)

	self.scoreBar = ScoreBar(self)
	self.gameplay = Gameplay(self)
end


function GameScene:initInputHandlers(state)
	pushInputHandlers(self.inputHandlers[state], true)
end


function GameScene:draw()
	print('GameScene:draw')

	self.ui = sprite.new()
	local ui <const> = self.ui

	-- fullscreen
	ui.img = gfx.image.new(400, 240, gfx.kColorClear)

	gfx.lockFocus(ui.img)
		gfx.setColor(gfx.kColorBlack)
		gfx.drawText('game scene', 159, 15)
		gfx.drawText('press A when the circle is inside', 80, 205)
	gfx.unlockFocus()

	ui:setImage(ui.img)
	ui:setCenter(0, 0)
	ui:moveTo(0, 0)
	ui:add()
end


function GameScene:gameover()
	self:initInputHandlers('gameover')
	self.gameover = Gameover(self)
end

function GameScene.restart(instance)
	instance.ui:remove()
	instance.gameplay.leaving(instance.gameplay)
	instance.scoreBar.leaving(instance.scoreBar)
	instance.gameover:obscuring()
	-- self:init(self.state)
	instance = nil

	local eventEmitter <const> = EventEmitter:init()
	eventEmitter:emit('state.switch', 'game.play')
end

function GameScene.leaving(instance)
	instance.gameplay.leaving(instance.gameplay)
	instance.scoreBar.leaving(instance.scoreBar)
	instance.gameover.leaving(instance.gameover)
	instance.ui:remove()
	instance = nil
end