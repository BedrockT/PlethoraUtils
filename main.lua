--Variables
local neuralI = peripheral.find("neuralI")



--Functions
function load_file(file)
	
	if (file ~= nil) then
	
		local ModF = io.open("", "r");
		local Mods = textutils.unserialise(ModF:read("*a"));

		ModF:close()
	
	

function abcdef()

--Main
if (not neuralI.hasModule("plethora:chat")) then
	print("WARN: Chat recorder (plethora:chat) is recommended");
end

local temp = io.open("filePaths.txt", "r");
filePaths = textutils.unserialise(temp:read("*a"));
temp:close();

while (true) do
