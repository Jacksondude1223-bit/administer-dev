local Signal = {}
Signal.__index = Signal

local Connection = require(script.Connection)

function Signal.new()
	local connectionSignal = setmetatable({}, Signal)
	connectionSignal.Connections = {}
	return connectionSignal
end

function Signal:Connect(setting: string, callback)
	local connection = Connection.new(callback, function(connectionToRemove)
		self.Connections[connectionToRemove] = nil
	end)
	self.Connections[connection] = setting
	return connection
end

function Signal:Fire(setting: string)
	for connection, connectionSetting in self.Connections do
		if connectionSetting == setting then
			connection:_Fire()
		end
	end
end

return Signal
