--[[


   _____            __    _ __  ___           __           
  / ___/__  _______/ /_  (_)  |/  /___ ______/ /____  _____
  \__ \/ / / / ___/ __ \/ / /|_/ / __ `/ ___/ __/ _ \/ ___/
 ___/ / /_/ (__  ) / / / / /  / / /_/ (__  ) /_/  __/ /    
/____/\__,_/____/_/ /_/_/_/  /_/\__,_/____/\__/\___/_/     
                                                           




____________________________________________________________________________________________________________________________________________________________________________
				
	[ UPDATE LOG v1.1 :]
1. New property!!
	Hitbox.Key = "insert anything you want here"
		--- This property will be used for the new function | module:FindHitbox(key)
		
2. New function!!
	Module:FindHitbox(Key)
		--- Returns a hitbox using specified Key, nil otherwise
		
3. New detection mode! | "ConstantDetection"
	Hitbox.DetectionMode = "ConstantDetection"
		--- The same as the default detection mode but no hit pool / debounce
		--- You're free to customize the debounce anyway you want
		
4, Made the scripts cleaner
____________________________________________________________________________________________________________________________________________________________________________
	
	[ UPDATE LOG v1.2 :]
1. Made the code better

____________________________________________________________________________________________________________________________________________________________________________
	
	[ UPDATE LOG v1.3 :]
1. New property
	HitboxObject.AutoDestroy = true (Default)
		---  With the value being false you can keep using Stop() 
		and Start() without the hitbox being destroyed.

2. New metamethod
	HitboxObject:Destroy()
		---  This destroys the hitbox. You only need to use this
			 When having AutoDestroy's value set to false.
			 
3. Minor bug fixes
			 
____________________________________________________________________________________________________________________________________________________________________________

	[ UPDATE LOG v1.4  Experimental:]
1. New event
	HitboxObject.TouchEnded:Connect(instance)
				Description
					--- The event fires once a part stops touching the hitbox
				Arguments
					--- Instance part: Returns the part that the hitbox stopped touching
					
____________________________________________________________________________________________________________________________________________________________________________

		 UPDATE LOG v1.5  Stable:]
1. Reverted touch ended, will add back after the bug is fixed

____________________________________________________________________________________________________________________________________________________________________________

		 UPDATE LOG v1.6  Stable:]
1. Touch ended is back! It has been fixed
2. HitboxObject.Key is now generated automatically
3. Minor changes

____________________________________________________________________________________________________________________________________________________________________________

	Example code:
		local module = require(game.ServerStorage.MuchachoHitbox)

		local hitbox = module.CreateHitbox()
		hitbox.Size = Vector3.new(10,10,10)
		hitbox.CFrame = workspace.Part

		hitbox.Touched:Connect(function(hit, hum)
			print(hit)
			hum:TakeDamage(10)
		end)
		
		hitbox:Start()
	
	
	Alright thats all for the example code, its a pretty simple module, you could make a module similar to this yourself.
	And maybe even make it better.
	
	If you encounter any bugs, please tell me in the comment section, or you could DM me on discord
	sushimaster#7840
	
	❤ SushiMaster
____________________________________________________________________________________________________________________________________________________________________________
	
	
	[MuchachoHitbox Documentation]

		* local Module = require(MuchachoHitbox)
				--- Require the module


			[ FUNCTIONS ]

		* Module.CreateHitbox()
				Description
					--- Creates a hitbox
					
		* Module:FindHitbox(Key)
				Description
					--- Returns a hitbox with specified Key

		* HitboxObject:Start()
				Description
					--- Starts the hitbox. 
					
		* HitboxObject:Stop()
				Description
					--- Stops the hitbox and resets the debounce.
					
		* HitboxObject:Destroy()
				Description
					--- Destroys the hitbox. Use this when you have
						HitboxObject.AutoDestroy set to false
					
			[ EVENTS ]

		* HitboxObject.Touched:Connect(hit, humanoid)
				Description
					--- If the hitbox touches a humanoid, it'll return information on them
					--- The hitbox can detect parts depending on the detection mode
				Arguments
					--- Instance part: Returns the part that the hitbox hit first
					--- Instance humanoid: Returns the Humanoid object 
					
		* HitboxObject.TouchEnded:Connect(instance)
				Description
					--- The event fires once a part stops touching the hitbox
				Arguments
					--- Instance part: Returns the part that the hitbox stopped touching
					
			[ PROPERTIES ]

		* HitboxObject.OverlapParams: OverlapParams
				Description
					--- Takes in a OverlapParams object

		* HitboxObject.Visualizer: boolean
				Description
					--- Turns on or off the visualizer part

		* HitboxObject.CFrame: CFrame / Instance
				Description
					--- Sets the hitbox CFrame to the CFrame
					--- If its an instance, then the hitbox would follow the instance
					
		* HitboxObject.Shape: Enum.PartType.Block / Enum.PartType.Ball
				Description
					--- Defaults to block
					--- Sets the hitbox shape to the property
					
		* HitboxObject.Size: Vector3 / number 
				Description
					--- Sets the size of the hitbox
					--- It uses Vector3 if the shape is block
					--- It uses number if the shape is ball
					
		* HitboxObject.Offset: CFrame
				Description
					--- Hitbox offset

		* HitboxObject.DetectionMode: string | "Default" , "HitOnce" , "HitParts" , "ConstantDetection"
				Description
					--- Default value set to "Default"
					--- Changes on how the detection works
					
		* HitboxObject.Key: String
				Description
					--- The key property for the find hitbox function
					--- MuchachoHitbox automatically generates a randomized key for you but you can change it. The module will save the hitbox, and can be found using | Module:FindHitbox(Key)
					
		* HitboxObject.AutoDestroy: boolean
				Description
					--- Default value is set to true
					--- When set to true, :Stop() atomatically destroys the hitbox.
					--- Does not destroy the hitbox when set to false. You'll 
						have to use :Destroy() to delete the hitbox.
			
			[ DETECTION MODES ]

		* Default
				Description
					--- Checks if a humanoid exists when this hitbox touches a part. The hitbox will not return humanoids it has already hit for the duration
					--- the hitbox has been active.

		* HitParts
				Description
					--- OnHit will return every hit part, regardless if it's ascendant has a humanoid or not.
					--- OnHit will no longer return a humanoid so you will have to check it. The hitbox will not return parts it has already hit for the
					--- duration the hitbox has been active.

		* HitOnce
				Description
					--- Hitbox will stop as soon as it detects a humanoid
					
		* ConstantDetection
				Description
					--- The default detection mode but no hitlist / debounce
					
____________________________________________________________________________________________________________________________________________________________________________

]]

local rs = game:GetService("RunService")
local hs = game:GetService("HttpService")

do
	local dictDiff = {}

local function find(a, tbl)
	for _, a_ in ipairs(tbl) do 
		if a_==a then return true end 
	end
end

function dictDiff.difference(a, b)
	local ret = {}
	for _, v in ipairs(a) do
		if not find(v,b) then table.insert(ret, v) end
	end
	
	return ret
end


return dictDiff
end

do
	--------------------------------------------------------------------------------
--               Batched Yield-Safe Signal Implementation                     --
-- This is a Signal class which has effectively identical behavior to a       --
-- normal RBXScriptSignal, with the only difference being a couple extra      --
-- stack frames at the bottom of the stack trace when an error is thrown.     --
-- This implementation caches runner coroutines, so the ability to yield in   --
-- the signal handlers comes at minimal extra cost over a naive signal        --
-- implementation that either always or never spawns a thread.                --
--                                                                            --
-- API:                                                                       --
--   local Signal = require(THIS MODULE)                                      --
--   local sig = Signal.new()                                                 --
--   local connection = sig:Connect(function(arg1, arg2, ...) ... end)        --
--   sig:Fire(arg1, arg2, ...)                                                --
--   connection:Disconnect()                                                  --
--   sig:DisconnectAll()                                                      --
--   local arg1, arg2, ... = sig:Wait()                                       --
--                                                                            --
-- Licence:                                                                   --
--   Licenced under the MIT licence.                                          --
--                                                                            --
-- Authors:                                                                   --
--   stravant - July 31st, 2021 - Created the file.                           --
--------------------------------------------------------------------------------

-- The currently idle thread to run the next handler on
local freeRunnerThread = nil

-- Function which acquires the currently idle handler runner thread, runs the
-- function fn on it, and then releases the thread, returning it to being the
-- currently idle one.
-- If there was a currently idle runner thread already, that's okay, that old
-- one will just get thrown and eventually GCed.
local function acquireRunnerThreadAndCallEventHandler(fn, ...)
	local acquiredRunnerThread = freeRunnerThread
	freeRunnerThread = nil
	fn(...)
	-- The handler finished running, this runner thread is free again.
	freeRunnerThread = acquiredRunnerThread
end

-- Coroutine runner that we create coroutines of. The coroutine can be 
-- repeatedly resumed with functions to run followed by the argument to run
-- them with.
local function runEventHandlerInFreeThread()
	-- Note: We cannot use the initial set of arguments passed to
	-- runEventHandlerInFreeThread for a call to the handler, because those
	-- arguments would stay on the stack for the duration of the thread's
	-- existence, temporarily leaking references. Without access to raw bytecode
	-- there's no way for us to clear the "..." references from the stack.
	while true do
		acquireRunnerThreadAndCallEventHandler(coroutine.yield())
	end
end

-- Connection class
local Connection = {}
Connection.__index = Connection

function Connection.new(signal, fn)
	return setmetatable({
		_connected = true,
		_signal = signal,
		_fn = fn,
		_next = false,
	}, Connection)
end

function Connection:Disconnect()
	self._connected = false

	-- Unhook the node, but DON'T clear it. That way any fire calls that are
	-- currently sitting on this node will be able to iterate forwards off of
	-- it, but any subsequent fire calls will not hit it, and it will be GCed
	-- when no more fire calls are sitting on it.
	if self._signal._handlerListHead == self then
		self._signal._handlerListHead = self._next
	else
		local prev = self._signal._handlerListHead
		while prev and prev._next ~= self do
			prev = prev._next
		end
		if prev then
			prev._next = self._next
		end
	end
end

-- Make Connection strict
setmetatable(Connection, {
	__index = function(tb, key)
		error(("Attempt to get Connection::%s (not a valid member)"):format(tostring(key)), 2)
	end,
	__newindex = function(tb, key, value)
		error(("Attempt to set Connection::%s (not a valid member)"):format(tostring(key)), 2)
	end
})

-- Signal class
local Signal = {}
Signal.__index = Signal

function Signal.new()
	return setmetatable({
		_handlerListHead = false,
	}, Signal)
end

function Signal:Connect(fn)
	local connection = Connection.new(self, fn)
	if self._handlerListHead then
		connection._next = self._handlerListHead
		self._handlerListHead = connection
	else
		self._handlerListHead = connection
	end
	return connection
end

-- Disconnect all handlers. Since we use a linked list it suffices to clear the
-- reference to the head handler.
function Signal:DisconnectAll()
	self._handlerListHead = false
end

-- Signal:Fire(...) implemented by running the handler functions on the
-- coRunnerThread, and any time the resulting thread yielded without returning
-- to us, that means that it yielded to the Roblox scheduler and has been taken
-- over by Roblox scheduling, meaning we have to make a new coroutine runner.
function Signal:Fire(...)
	local item = self._handlerListHead
	while item do
		if item._connected then
			if not freeRunnerThread then
				freeRunnerThread = coroutine.create(runEventHandlerInFreeThread)
				-- Get the freeRunnerThread to the first yield
				coroutine.resume(freeRunnerThread)
			end
			task.spawn(freeRunnerThread, item._fn, ...)
		end
		item = item._next
	end
end

-- Implement Signal:Wait() in terms of a temporary connection using
-- a Signal:Connect() which disconnects itself.
function Signal:Wait()
	local waitingCoroutine = coroutine.running()
	local cn;
	cn = self:Connect(function(...)
		cn:Disconnect()
		task.spawn(waitingCoroutine, ...)
	end)
	return coroutine.yield()
end

-- Implement Signal:Once() in terms of a connection which disconnects
-- itself before running the handler.
function Signal:Once(fn)
	local cn;
	cn = self:Connect(function(...)
		if cn._connected then
			cn:Disconnect()
		end
		fn(...)
	end)
	return cn
end

-- Make signal strict
setmetatable(Signal, {
	__index = function(tb, key)
		error(("Attempt to get Signal::%s (not a valid member)"):format(tostring(key)), 2)
	end,
	__newindex = function(tb, key, value)
		error(("Attempt to set Signal::%s (not a valid member)"):format(tostring(key)), 2)
	end
})

return Signal

end

local GoodSignal = Signal
local DictDiff = dictDiff

local muchacho_hitbox = {}
muchacho_hitbox.__index = muchacho_hitbox

local HITBOX_COLOR = Color3.fromRGB(255,0,0)
local HITBOX_TRANSPARENCY = 0.8


local adornment_form = {
	["Proportion"] = {
		[Enum.PartType.Ball] = "Radius",
		[Enum.PartType.Block] = "Size",
	},

	["Shape"] = {
		[Enum.PartType.Ball] = "SphereHandleAdornment",
		[Enum.PartType.Block] = "BoxHandleAdornment",
	},
}

local get_CFrame = {
	["Instance"] = function(point)
		return point.CFrame
	end,

	["CFrame"] = function(point)
		return point
	end,
}

local spatial_query = {
	[Enum.PartType.Ball] = function(self)
		local point_type = typeof(self.CFrame)
		local point_cframe = get_CFrame[point_type](self.CFrame)

		local parts = workspace:GetPartBoundsInRadius(point_cframe.p + self.Offset.p, self.Size, self.OverlapParams)

		return parts
	end,

	[Enum.PartType.Block] = function(self)
		local point_type = typeof(self.CFrame)
		local point_cframe = get_CFrame[point_type](self.CFrame)

		local parts = workspace:GetPartBoundsInBox(point_cframe * self.Offset, self.Size, self.OverlapParams)

		return parts
	end,
}

local hitboxes = {}


function muchacho_hitbox.CreateHitbox()
	return setmetatable({
		Visualizer = true,
		DetectionMode = "Default",
		AutoDestroy = true,	
		Key = hs:GenerateGUID(false),

		HitList = {},
		TouchingParts = {},

		Connection = nil,
		Box = nil,

		Touched = GoodSignal.new(),
		TouchEnded = GoodSignal.new(),

		OverlapParams = OverlapParams.new(),

		Size = Vector3.new(0,0,0),
		Shape = Enum.PartType.Block,
		CFrame = CFrame.new(0,0,0),
		Offset = CFrame.new(0,0,0)

	}, muchacho_hitbox)
end

function muchacho_hitbox:FindHitbox(key)
	if hitboxes[key] then
		return hitboxes[key]
	end
end

function muchacho_hitbox:_visualize()
	if not self.Visualizer then return end

	local point_type = typeof(self.CFrame)
	local point_cframe = get_CFrame[point_type](self.CFrame)

	local proportion = adornment_form.Proportion[self.Shape]

	if self.Box then
		self.Box.CFrame = point_cframe * self.Offset
	else
		self.Box = Instance.new(adornment_form.Shape[self.Shape])
		self.Box.Name = "Visualizer"
		self.Box.Adornee = workspace.Terrain
		self.Box[proportion] = self.Size
		self.Box.CFrame = point_cframe * self.Offset
		self.Box.Color3 = HITBOX_COLOR
		self.Box.Transparency = HITBOX_TRANSPARENCY
		self.Box.Parent = workspace.Terrain
	end
end

function muchacho_hitbox:_InsertTouchingParts(part)
	if table.find(self.TouchingParts, part) then return end

	table.insert(self.TouchingParts, part)
end

function muchacho_hitbox:_FindTouchEnded(parts)
	if not self.TouchingParts[1] then return end

	local mode = self.DetectionMode
	local differences = DictDiff.difference(self.TouchingParts, parts)

	if differences then
		for _, diff in ipairs(differences) do
			self.TouchEnded:Fire(diff)
			table.remove(self.TouchingParts, table.find(self.TouchingParts, diff))
		end
	end
end

function muchacho_hitbox:_cast()
	local mode = self.DetectionMode
	local parts = spatial_query[self.Shape](self)

	self:_FindTouchEnded(parts)

	for _, hit in pairs(parts) do
		local character = hit:FindFirstAncestorOfClass("Model") or hit.Parent
		local humanoid = character:FindFirstChildOfClass("Humanoid")

		-- detection mode
		if mode == "Default" and humanoid and not self.HitList[table.find(self.HitList, humanoid)] then
			table.insert(self.HitList, humanoid)
			self:_InsertTouchingParts(hit)

			self.Touched:Fire(hit, humanoid)

		elseif mode == "ConstantDetection" and humanoid then
			self:_InsertTouchingParts(hit)

			self.Touched:Fire(hit, humanoid)

		elseif mode == "HitOnce" and humanoid then
			self:_InsertTouchingParts(hit)

			self.Touched:Fire(hit, humanoid)
			self.TouchEnded:Fire(hit)

			self:Stop()
			break

		elseif mode == "HitParts" then
			self:_InsertTouchingParts(hit)

			self.Touched:Fire(hit)

		end
	end
end

function muchacho_hitbox:_clear()
	self.HitList = {}

	if self.Connection then
		self.Connection:Disconnect()
	end

	if self.Key then
		hitboxes[self.Key] = nil
	end

	if self.Box then
		self.Box:Destroy()
		self.Box = nil
	end
end

function muchacho_hitbox:Start()
	if hitboxes[self.Key] then
		error("A hitbox with this Key has already been started. Change the key if you want to start this hitbox.")
	end

	hitboxes[self.Key] = self

	-- looping the hitbox
	task.spawn(function()	
		self.Connection = rs.Heartbeat:Connect(function()
			self:_visualize()
			self:_cast()
		end)
	end)
end

function muchacho_hitbox:Stop()
	-- clear hitbox
	self:_clear()

	if not self.AutoDestroy then return end

	-- terminate hitbox
	self.Touched:DisconnectAll()
	self.TouchEnded:DisconnectAll()
	setmetatable(self, nil)
end

function muchacho_hitbox:Destroy()
	-- clear hitbox
	self:_clear()

	-- terminate hitbox
	self.Touched:DisconnectAll()
	self.TouchEnded:DisconnectAll()
	setmetatable(self, nil)
end

return muchacho_hitbox
