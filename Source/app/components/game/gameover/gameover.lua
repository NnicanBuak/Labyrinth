import 'CoreLibs/sprites'

local gfx <const> = playdate.graphics
local sprite <const> = gfx.sprite
local easing <const> = playdate.easingFunctions

class('Gameover').extends()

function Gameover:init(game)
	print('Gameover:init')

	self.game = game
	self:draw()
end

function Gameover:draw()
	print('Gameover:draw')

	self.ui = sprite.new()
	local ui <const> = self.ui

	-- fullscreen
	ui.img = gfx.image.new(300, 100, gfx.kColorWhite)

	gfx.lockFocus(ui.img)
		gfx.setColor(gfx.kColorBlack)
		gfx.drawText('GAME OVER', 110, 15)
		gfx.drawText('press A to restart game', 60, 50)
		gfx.drawText('press B to back to the main screen', 20, 70)
		gfx.drawRect(0, 0, 298, 98)
	gfx.unlockFocus()

	ui:setImage(ui.img)
	ui:setCenter(0.5, 0.5)
	ui:moveTo(200, -60)
	ui:setZIndex(50)
	ui:add()

	self.show = function ()
		local timer <const> = playdate.frameTimer.new(45, self.ui.y, 120, easing.outElastic)

		timer.updateCallback = function(t)
			self.ui:moveTo(self.ui.x, t.value)
		end

		timer.timerEndedCallback = function ()
			self:revealed()
		end
	end

	self.hide = function ()
		local timer <const> = playdate.frameTimer.new(25, self.ui.y, -60, easing.linear)

		timer.updateCallback = function(t)
			self.ui:moveTo(self.ui.x, t.value)
		end

		timer.timerEndedCallback = function ()
			self.leaving(self)
		end
	end

	playdate.timer.new(500, self.show)

end

function Gameover:revealed()
	self.game:initInputHandlers('gameover_revealed')
end

function Gameover:obscuring()
	playdate.timer.new(250, self.hide)
end

function Gameover.leaving(instance)
	instance.ui:remove()
	instance = nil
end