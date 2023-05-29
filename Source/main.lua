import 'CoreLibs/graphics'
import 'CoreLibs/sprites'
import 'CoreLibs/timer'
import 'CoreLibs/frameTimer'

import 'app/app'

-- Global variables
playdate.screenWidth = 400
playdate.screenHeight = 240
playdate.screenWidthCenterAlignDevice = 228

-- FRAME = 0
APP = App()


-- Local variables

local gfx <const> = playdate.graphics
local gfxSpriteUpdate <const> = gfx.sprite.update
local updateTimers <const> = playdate.timer.updateTimers
local updateFrameTimers <const> = playdate.frameTimer.updateTimers

-- DEBUG
-- local drawFPS <const> = playdate.drawFPS
-- local printCurrentFrame <const> = function ()
-- 	FRAME += 1
-- 	print('')
-- 	print('['..FRAME..']')
-- end

-- APP
APP:start()

-- PLAYDATE
function playdate.update()
	-- DEBUG
	-- printCurrentFrame()
	-- drawFPS(382, 226)

	updateTimers()
	updateFrameTimers()
	gfxSpriteUpdate()
end
