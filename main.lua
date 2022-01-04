--Variables
local neuralI = peripheral.find("neuralInterface")
local coroutines = {}


--Functions
function load_file(file, args)
	
	if (file ~= nil and coroutines[file] == nil) then
	
		local ModF = io.open(filePaths[file], "r");
		local Mod = loadstring(ModF:read("*a"));

		ModF:close();
		
		coroutines[file] = coroutine.create(Mod);
		if (args) then
			coroutine.resume(coroutines[file]);
		end
	end
end
	
		
--Main
if (not neuralI.hasModule("plethora:chat")) then
	print("WARN: Chat recorder (plethora:chat) is recommended");
end

local temp = io.open("PlethoraUtils/filePaths.txt", "r");
filePaths = textutils.unserialise(temp:read("*a"));
temp:close();

load_file("orescan", "minecraft:redstone_ore")
while (true) do
	for _, v in pairs(coroutines) do
		coroutine.resume(v);
		sleep(0.05);
	end
	sleep(0.05);
end
