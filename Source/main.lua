import 'CoreLibs/graphics'
import 'CoreLibs/sprites'
import 'CoreLibs/timer'
import 'CoreLibs/frameTimer'

import 'app/app'

-- Global

-- FRAME = 0
APP = App()


-- Local

local gfx <const> = playdate.graphics
local gfxSpriteUpdate <const> = gfx.sprite.update
local updateTimers <const> = playdate.timer.updateTimers
local updateFrameTimers <const> = playdate.frameTimer.updateTimers
-- local drawFPS <const> = playdate.drawFPS
-- local printCurrentFrame <const> = function ()
-- 	FRAME += 1
-- 	print('')
-- 	print('['..FRAME..']')
-- end

APP:start()

function playdate.update()
	-- printCurrentFrame()
	-- drawFPS(382, 226)

	updateTimers()
	updateFrameTimers()
	gfxSpriteUpdate()
end
