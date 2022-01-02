--Variables
local neuralI = peripheral.find("neuralI")

--Functions
function run()

--Main
if (not neuralI.hasModule("plethora:chat")) then
	print("WARN: Chat recorder (plethora:chat) is recommended");
end



while (true) do
