-- Pull in Gamestate from the HUMP library
Gamestate = require 'libs.hump.gamestate'

-- Pull in each of our game states
local mainMenu = require 'gamestates.mainmenu'
local gameLevel1 = require 'gamestates.gameLevel1'
local gameLevel2 = require 'gamestates.gameLevel2'
local levelFinished = require 'gamestates.levelFinished'
local pause = require 'gamestates.pause'
local gameover = require 'gamestates.gameover'

function love.load()
  love.window.setFullscreen(true, "desktop")
  Gamestate.registerEvents()
  Gamestate.switch(mainMenu)
end

function love.keypressed(key)
  if key == "escape" then
		love.event.push("quit")
	end

  if Gamestate.current() ~= mainMenu and Gamestate.current() ~= pause and key == 'p' then
    Gamestate.push(pause)
  end
end