-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local centerX = display.contentCenterX
-- set centerY
local centerY = display.contentCenterY
-- Your code here

local composer = require("composer") --require composer library

display.setStatusBar(display.HiddenStatusBar)




composer.gotoScene("scene1")

--local dataPath = system.pathForFile ("db",system.DocumentsDirectory)
--db = sqlite3.open(dataPath)
--
--local tablesetup = [[CREATE TABLE IF NOT EXISTS profiles(id INTEGER PRIMARY KEY AUTOINCREMENT, name, age);]]
--print(tablesetup)
--
--db: exec( tablesetup)
--
--local tablefill = [[INSERT INTO profiles VALUES(NULL, 'Fred','9');]]
--print(tablefill)
--
--db: exec( tablefill)
--
--local counter = 0
--for row in db:nrows("SELECT * FROM profiles") do
--    local text = row.name .." "..row.age.." "..row.id
--    local t = display.newText(text,centerX,100+counter*20,native.systemFont, 16)
--    counter = counter+1
--    t: setFillColor (1,0,1)
--end

