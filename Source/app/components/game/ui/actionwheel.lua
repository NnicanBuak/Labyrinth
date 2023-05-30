import 'app/utils/event-emitter'
import 'app/utils/table'

local gfx <const> = playdate.graphics
local sprite <const> = gfx.sprite

local RainsFont1x <const> = gfx.font.new('assets/fonts/Rains/font-rains-1x')
local RainsFont2x <const> = gfx.font.new('assets/fonts/Rains/font-rains-2x')
local RainsFont3x <const> = gfx.font.new('assets/fonts/Rains/font-rains-3x')

class('Actionwheel').extends()

function Actionwheel:init(game)
  print('Actionwheel:init', self)

  self.game = game
  self.eventEmitter = EventEmitter:init()

  self.onUpdateHandler = function(actions)
    self:update(actions)
  end

  self.eventEmitter:on('actionwheel.update', self.onUpdateHandler)

  self.actionwheel = { 'Attack 1', 'Attack 2', 'Attack 3' }

  self.action = 'Attack 1'

  self:initUi()
  self:draw()
end

function Actionwheel:initUi()
  print('Actionwheel:initUi')

  self.ui = sprite.new()
  local ui <const> = self.ui
  -- fullscreen
  ui.img = gfx.image.new(200, 100, gfx.kColorClear)

  ui:setImage(ui.img)
  ui.img = ui:getImage()
  ui:setCenter(0.5, 0.5)
  ui:moveTo(playdate.screenWidth - 100, playdate.screenHeight - 50)
  ui:add()
end

function Actionwheel:draw()
  print('Actionwheel:draw')
  print('	ui', self.ui)
  print('	img', self.ui.img)

  self.ui.img:clear(gfx.kColorClear)

  gfx.lockFocus(self.ui.img)

  gfx.setColor(gfx.kColorBlack)
  gfx.setFont()
  for index, action in pairs(self.actionwheel) do
    if index > 3 then
      break
    elseif index == 1 then
      gfx.setFont(RainsFont2x)
      gfx.drawTextAligned(action, 120, 60, kTextAlignment.center)
    elseif index == 2 then
      gfx.setFont(RainsFont1x)
      gfx.drawTextAligned(action, 120, 80 - 20 * index, kTextAlignment.center)
    end
  end

  gfx.unlockFocus()
end

function Actionwheel:clear()
  print('Actionwheel:clear')
  print('	ui', self.ui)
  print('	img', self.ui.img)

  self.ui.img:clear(gfx.kColorClear)
end

function Actionwheel:update(actions)
  print('Actionwheel:open')

  self.actionwheel = actions
  self:draw()
end

function Actionwheel:open()
  print('Actionwheel:open')

  self:draw()
end

function Actionwheel:close()
  print('Actionwheel:close')

  self:clear()
end

function Actionwheel:nextItem()
  print('Actionwheel:nextItem')

  self:draw()
end

function Actionwheel:previousItem()
  print('Actionwheel:previousItem')

  self:draw()
end

function Actionwheel:getAction()
  print('Actionwheel:getAction')
end

function Actionwheel.leaving(instance)
  instance.ui:remove()
  instance.eventEmitter:off('actionwheel.update', instance.onUpdateHandler)
  instance = nil
end
