import 'app/utils/event-emitter'
import 'app/utils/table'

local gfx <const> = playdate.graphics
local sprite <const> = gfx.sprite

class('Actionwheel').extends()

function Actionwheel:init(gameplay)
  print('Actionwheel:init', self)

  self.gameplay = gameplay

  self.actions = { 'Attack 1', 'Attack 2', 'Attack 3' }

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

function Actionwheel:update(actions)
  print('Actionwheel:open')

  self.actions = actions
  self:draw()
  if not (APP.uiSoundSample == nil) then
    APP.uiSoundSample:play()
  end
end

function Actionwheel:draw()
  print('Actionwheel:draw')
  print('	ui', self.ui)
  print('	img', self.ui.img)

  self:clear()

  gfx.lockFocus(self.ui.img)

  gfx.setColor(gfx.kColorBlack)
  gfx.setFont()
  for index, action in pairs(self.actions) do
    if index > 2 then
      gfx.setFont(APP.fontRains2x)
      gfx.drawTextAligned(self.actions[#self.actions], 120, 85, kTextAlignment.center)
      break
    elseif index == 1 then
      gfx.setFont(APP.RainsFont2x)
      gfx.drawTextAligned(action, 120, 60, kTextAlignment.center)
    elseif index == 2 then
      gfx.setFont(APP.fontRains1x)
      gfx.drawTextAligned(action, 120, 42, kTextAlignment.center)
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

  local actionsInstance = self.actions
  local firstItem = table.remove(actionsInstance, 1)
  table.insert(actionsInstance, firstItem)
  self:update(actionsInstance)
end

function Actionwheel:previousItem()
  print('Actionwheel:previousItem')

  local actionsInstance = self.actions
  local lastItem = table.remove(actionsInstance)
  table.insert(actionsInstance, 1, lastItem)
  self:update(actionsInstance)
end

function Actionwheel:getAction()
  print('Actionwheel:getAction')
end

function Actionwheel.leaving(instance)
  instance.ui:remove()
  instance.eventEmitter:off('actionwheel.update', instance.onUpdateHandler)
  instance = nil
end
