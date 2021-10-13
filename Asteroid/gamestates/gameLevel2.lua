-- Import our libraries.
local Gamestate = require 'libs.hump.gamestate'
local Class = require 'libs.hump.class'
local Entities = require 'entities.Entities'

-- Grab our base class
local LevelBase = require 'gamestates.LevelBase'

-- Import the Entities we will build.
local Player = require 'entities.player'
local Invader = require 'entities.invader'

local gameLevel2 = Class{
  __includes = LevelBase
}

function gameLevel2:init()
  LevelBase.init(self)--clear
  level = 2
  invaderLevelCount = 50
  invaderLevelTimer = 0.25
  canShootTimerMax = 1
  invaderBulletSpeed = 200
  spaceImg = love.graphics.newImage('img/space2.jpg')
end

function gameLevel2:enter()
  LevelBase:enter()
end

function gameLevel2:update(dt)
  LevelBase:update(dt)
end

function gameLevel2:draw()
  LevelBase.draw()
end

function gameLevel2:keypressed(key)
  LevelBase:keypressed(key)
end

return gameLevel2