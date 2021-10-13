local Class = require 'libs.hump.class'
local Entities = require 'entities.Entities'
local Entity = require 'entities.Entity'

local playerBullet = Class{
  __includes = Entity -- Player class inherits our Entity class
}

function playerBullet:init(x, y)
  
  self.img = love.graphics.newImage('img/bullet.png')
  self.speed = 250
  Entity.init(self, 'playerBullet', x, y, self.img:getWidth(), self.img:getHeight())
  
end

function playerBullet:update(dt)
  
  self.y = self.y - (self.speed * dt)
  if self.y < 0 then -- remove bullets when they pass off the screen
    Entities:remove(self)
  end
  
end

function playerBullet:draw()
  
  love.graphics.draw(self.img, self.x, self.y)
  
end

return playerBullet