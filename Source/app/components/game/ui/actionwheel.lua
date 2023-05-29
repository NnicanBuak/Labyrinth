import 'app/utils/event-emitter'
import 'app/utils/table'

local gfx <const> = playdate.graphics
local sprite <const> = gfx.sprite
local columnFont12 <const> = gfx.font.new('assets/fonts/Column/Column/12/')
local columnFont18 <const> = gfx.font.new('assets/fonts/Column/Column/18/')

class('Actionwheel').extends()

function Actionwheel:init(game)
  print('Actionwheel:init', self)

  self.game = game
  self.eventEmitter = EventEmitter:init()

  self.onUpdateHandler = function(actions)
    self:open(actions)
  end

  self.eventEmitter:on('actionwheel.update', self.onUpdateHandler)

  self.actionwheel = { 'Attack 1', 'Attack 2', 'Attack 3' }

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
  for index, action in pairs(self.actionwheel) do
    if index > 3 then
      break
    elseif index == 1 then
      gfx.setFont(columnFont18)
      gfx.drawText(action, 100, 60)
    else
      gfx.setFont(columnFont12)
      gfx.drawText(action, 100, 60 - 20 * index)
    end
  end

  gfx.unlockFocus()
end

function Actionwheel:update(actions)
  print('Actionwheel:open')

  self.actionwheel = actions
  self:draw()
end

function Actionwheel:nextItem()
  print('Actionwheel:nextItem')

  self:draw()
end

function Actionwheel:previousItem(actions)
  print('Actionwheel:previousItem')

  self.actionwheel = actions
  self:draw()
end

function Actionwheel.leaving(instance)
  instance.ui:remove()
  instance.eventEmitter:off('actionwheel.update', instance.onUpdateHandler)
  instance = nil
end
