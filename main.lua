--Variables
local neuralI = peripheral.find("neuralI")
local coroutines = {}


--Functions
function load_file(file)
	
	if (file ~= nil and coroutines[file] == nil) then
	
		local ModF = io.open(filePaths[file], "r");
		local Mod = loadstring(ModF:read("*a"));

		ModF:close();
		
		coroutines[file] = coroutine.create(Mod);
		
	end
end
	
		
--Main
if (not neuralI.hasModule("plethora:chat")) then
	print("WARN: Chat recorder (plethora:chat) is recommended");
end

local temp = io.open("filePaths.txt", "r");
filePaths = textutils.unserialise(temp:read("*a"));
temp:close();
