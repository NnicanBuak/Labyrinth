import 'CoreLibs/graphics'
import 'CoreLibs/sprites'
import 'CoreLibs/timer'
import 'CoreLibs/frameTimer'

import 'app/app'

-- Local variables
local gfxSpriteUpdate <const>         = playdate.graphics.sprite.update
local updateTimers <const>            = playdate.timer.updateTimers
local updateFrameTimers <const>       = playdate.frameTimer.updateTimers

playdate.screenWidth                  = 400
playdate.screenHeight                 = 240
playdate.screenWidthCenterAlignDevice = 228

-- FRAME = 0
APP                                   = App()

-- APP
APP:start()

-- PLAYDATE
function playdate.update()
	updateTimers()
	updateFrameTimers()
	gfxSpriteUpdate()
end
