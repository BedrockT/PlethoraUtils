--Variables
local neuralI = peripheral.find("neuralI")

--Functions
function loadModules()

	local readAll = function(tabl)
		for _, v in pairs(tabl) do
			if (type(v) == "table") then
				readAll(v)
			elseif (type(v) == "string") then
				os.loadAPI(v);
			end
		end
	end
	
	local ModF = io.open("./Modules.txt", "r");
	local Mods = textutils.unserialise(ModF:read("*a"));
	
	ModF:close()
	
	

function run()

--Main
if (not neuralI.hasModule("plethora:chat")) then
	print("WARN: Chat recorder (plethora:chat) is recommended");
end



while (true) do
