
--[[
	* @class EventEmitter
	* singleton by default
]]--


EventEmitter = {}
EventEmitter.__index = EventEmitter

local _eventEmitterInstance

--[[
	* Create new EventEmitter
]]--

--[[
	* Init singleton
]]--

function EventEmitter:init()
	
	if (not _eventEmitterInstance) then
		_eventEmitterInstance = self:create()
	end
	
	return _eventEmitterInstance
end


--[[
	* Create new EventEmitter
]]--

function EventEmitter:create()

	local ee = {}
	setmetatable(ee, EventEmitter)
	ee._events = Table{}

	return ee
end

-- function EventEmitter:create()
-- 
-- 	local ee = {}
-- 	setmetatable(ee, EventEmitter)
-- 	-- ee._events = {}
-- 	ee._events = Table{}
-- 
-- 	return ee
-- end

--[[
	* Create new EventEmitter (singleton)
]]--

-- function EventEmitter:init()
-- 
-- 	if _eventEmitterInstance then
-- 		return _eventEmitterInstance
-- 	end
-- 
-- 	_eventEmitterInstance = self:create()
-- 
-- 	return _eventEmitterInstance
-- end


function EventEmitter:on(name, listener)

	print('EventEmitter:on')
	print('	name', name)

	self._events[name] = self._events[name] or Table{}

	local events = self._events[name]
	local found = false

	-- Check the duplicate
	if #events > 0 then
		for _,v in pairs(events) do
			if v == listener then
				found = true
				break
			end
		end
	end

	if not found then
		events:push(listener)
	end
end


function EventEmitter:off(name, listener)

	print('EventEmitter:off')
	print('	name', name)
	print('	listener', listener)

	local index = self._events[name]:indexOf(listener)

	if index ~= -1 then
		table.remove(self._events[name], index)
	end
end


function EventEmitter:emit(name, attr)

	print('EventEmitter:emit')
	print('	name', name)

	local events = self._events[name]

	if events and #events then
		for _,listener in pairs(events) do
			listener(attr)
		end
	end
end
