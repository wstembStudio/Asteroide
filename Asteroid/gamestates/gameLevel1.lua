-- Import our libraries.
local Gamestate = require 'libs.hump.gamestate'
local Class = require 'libs.hump.class'
local Entities = require 'entities.Entities'

-- Grab our base class
local LevelBase = require 'gamestates.LevelBase'

-- Import the Entities we will build.
local Player = require 'entities.player'
local Invader = require 'entities.invader'

local gameLevel1 = Class{
  __includes = LevelBase
}

function gameLevel1:init()
  LevelBase.init(self)--clear
  level = 1
  invaderLevelCount = 1
  invaderLevelTimer = 1
  canShootTimerMax = 5
  invaderBulletSpeed = 20
  spaceImg = love.graphics.newImage('img/space1.jpg')
end

function gameLevel1:enter()
  LevelBase:enter()
end

function gameLevel1:update(dt)
  LevelBase:update(dt)
end

function gameLevel1:draw()
  LevelBase.draw()
end

function gameLevel1:keypressed(key)
  LevelBase:keypressed(key)
end

return gameLevel1