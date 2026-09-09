local Connection = {}
Connection.__index = Connection

function Connection.new(callback, disconnectCallback)
	local newConnection = setmetatable({}, Connection)
	newConnection.callback = function(...)
		callback(...)
	end
	newConnection.disconnectCallback = disconnectCallback
	return newConnection
end

function Connection:_Fire()
	if self.callback then
		task.spawn(self.callback)
	end
end

function Connection:Disconnect()
	self.callback = nil
	if self.disconnectCallback then
		self.disconnectCallback(self)
		self.disconnectCallback = nil
	end
end

return Connection
