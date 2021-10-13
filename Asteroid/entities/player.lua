-- Import our libraries.
local Gamestate = require 'libs.hump.gamestate'
local Class = require 'libs.hump.class'
local Entities = require 'entities.Entities'
local Entity = require 'entities.Entity'

-- Import the Entities we will build.
local PlayerBullet = require 'entities.PlayerBullet'

playerCanShoot = true
playerCanShootTimerMax = 0.2
playerCanShootTimer = playerCanShootTimerMax

local player = Class{
  __includes = Entity -- Player class inherits our Entity class
}

function player:init()
  
  self.img = love.graphics.newImage('img/player.png')
  initialX = (love.graphics.getWidth()-self.img:getWidth()) /2 
  initialY = love.graphics.getHeight()-self.img:getHeight() 
  self.speed = 500
  Entity.init(self, 'player', initialX, initialY, self.img:getWidth(), self.img:getHeight())

end

function player:update(dt)
  
  if love.keyboard.isDown('left','a') then
    if self.x > 0 then
      self.x = self.x - (self.speed*dt)
    end
  elseif love.keyboard.isDown('right','d') then
    if self.x < (love.graphics.getWidth() - self.img:getWidth()) then
      self.x = self.x + (self.speed*dt)
    end
  end
  
  playerCanShootTimer = playerCanShootTimer - (1 * dt)
  if playerCanShootTimer < 0 then
    playerCanShoot = true
  end
  if love.keyboard. isDown('space') and playerCanShoot then
    x = self.x + (self.img:getWidth()/2) - 4.5
    y = - 12 + self.y
    playerBullet = PlayerBullet(x, y)
    Entities:add(playerBullet)
    playerCanShoot = false
    playerCanShootTimer = playerCanShootTimerMax
  end
  
end

function player:draw()
  love.graphics.draw(self.img, self.x, self.y)
end

return player