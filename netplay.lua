require "netplayinc/MiddleClass"
require "netplayinc/LUBE"
require "netplayinc/umsg"
require "server"
require "client"

motd = "No griefing, no TNT, minecraft servers suck."
chatmessages = {}
playerlist = {}
localnick = "Player" -- Your nickname here
ip = "127.0.0.1" -- Server IP here
--ip = "127.0.0.1" -- Server IP here
max_players = 2 -- Max player count here (max: 4)
port = 4000 -- Custom port here (default: 4000)
updatedelay = 0.02 -- Update every X seconds!
rempausemenuopen = false


SERVER = false
CLIENT = false
netplay = false

function netplay_update(dt)
	if SERVER then
		server_update(dt)
	elseif CLIENT then
		client_update(dt)
	end
end

function deserialize(str)
	output = str:split("~")
	return output
end

function serialize(str1,str2)
	return str1.."~"..str2
end

function message(s)
	print(os.date("%X", os.time()) .. " " .. s)
	table.insert(console.lines, os.date("%X", os.time()) .. " " .. s)
	local height=love.graphics.getHeight()
   if(#console.lines>(37)) then table.remove(console.lines,1) end
end