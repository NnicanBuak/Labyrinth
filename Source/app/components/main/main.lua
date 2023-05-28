import 'CoreLibs/sprites'

local gfx <const> = playdate.graphics
local sprite <const> = gfx.sprite
local pushInputHandlers <const> = playdate.inputHandlers.push

class('MainScene').extends()

function MainScene:init(state)
	print('MainScene:init')

	self.state = state

	self:initInputHandlers()
	self:draw()
end

function MainScene:initInputHandlers()

	local inputHandlers <const> = {
		AButtonUp =  function()
			self.state.manager:switch('game.play')
		end,
	}

	pushInputHandlers(inputHandlers, true)
end


function MainScene:draw()
	print('MainScene:draw')

	self.ui = sprite.new()
	local ui <const> = self.ui

	-- fullscreen
	ui.img = gfx.image.new(400, 240, gfx.kColorClear)

	gfx.lockFocus(ui.img)
		gfx.setColor(gfx.kColorBlack)
		gfx.drawText('main scene', 159, 15)
		gfx.drawText('press A to start', 140, 205)
	gfx.unlockFocus()

	ui:setImage(ui.img)
	ui:setCenter(0, 0)
	ui:moveTo(0, 0)
	ui:add()
end

function MainScene.leaving(instance)
	instance.ui:remove()
	instance = nil
end