--Code Stolen from plethora.madefor.cc/examples/ore-scanner.html
 
local modules = peripheral.find("neuralInterface");
 
-- Scan-related Variables
local scanInterval = 0.06;
local renderInterval = 0.05;
local scannerRange = 8;
local scannerWidth = scannerRange * 2 + 1;
 
-- Visual-related Variables
local size = 0.5;
local cellSize = 16;
local offsetX = 75;
local offsetY = 75;
 
local canvas = modules.canvas().addGroup({1, 1});
 
local ores = {
 
    ["minecraft:lava"] = true
    
}
 
local clrs = {
 
    ["minecraft:lava"] = {150, 75, 0},
    ["minecraft:gold_ore"] = {255, 255, 0},
    ["minecraft:diamond_ore"] = {0, 255, 255},
    ["minecraft:lapis_ore"] = {0, 50, 255},
    ["minecraft:emerald_ore"] = {0, 255, 0},
    ["minecraft:coal_ore"] = {150, 150, 150},
    ["minecraft:iron_ore"] = {255, 150, 50},
    ["minecraft:redstone_ore"] = {255, 0, 0}
    
};
 
local textBlock = {};
local blocks = {};
   
--Scan Blocks        
local function scan()
    while (true) do
    
        local scanned_blocks = modules.scan();
        
        for x = -scannerRange, scannerRange, 1 do
            for z = -scannerRange, scannerRange, 1 do
            
                local by, block = 0;
            
                for y = -scannerRange, scannerRange, 1 do
 			
                    local scanned = scanned_blocks[scannerWidth ^ 2 * (x + scannerRange) + scannerWidth * (y + scannerRange) + (z + scannerRange) + 1]
                    
                    if (ores[scanned.name]) then
                        block = scanned.name;
                        by = y; 
                    end
                    
                    blocks[x][z].block = block;
                    blocks[x][z].y = by;
                    
                end  
            end
        end
    sleep(scanInterval);
    end
end
 
--Render
local function render() 
    while (true) do

        local meta = modules.getMetaOwner and modules.getMetaOwner();
        local angle = meta and math.rad(-meta.yaw % 360) or math.rad(180);
        
        for x = -scannerRange, scannerRange, 1 do
            for z = -scannerRange, scannerRange, 1 do
            
                local text = textBlock[x][z];
                local block = blocks[x][z];
                
                if (block.block) then
                    local px = math.cos(angle) * -x - math.sin(angle) * -z;
                    local py = math.sin(angle) * -x + math.cos(angle) * -z;
                    
                    local sx = math.floor(px * size * cellSize);
                    local sy = math.floor(py * size * cellSize);
                    text.setPosition(offsetX + sx, offsetY + sy);
                    
                    text.setText(tostring(block.y));
                    text.setColor(table.unpack(clrs[block.block]));
                 else
                    text.setText(" ");  
                end 
            end 
        end
        sleep(renderInterval); 
    end 
end
    
for x = -scannerRange, scannerRange, 1 do
 
	textBlock[x] = {};
	blocks[x] = {};
    
    for z = -scannerRange, scannerRange, 1 do
    
		textBlock[x][z] = canvas.addText({ 0, 0 }, " ", 0xFFFFFFFF, size);
        blocks[x][z] = { y = nil, block = nil };
        
    end
	
end
	
canvas.addText({offsetX, offsetY}, "^", 0xFFFFFF90, size*2);    
if (bID ~= nil) then ores[bID] = true; modules.tell("scanning for " .. bID); end

coroutine.yield();
while (true) do
	scan()
	render()
	coroutine.yield();
end
