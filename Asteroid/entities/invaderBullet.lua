local Class = require 'libs.hump.class'
local Entities = require 'entities.Entities'
local Entity = require 'entities.Entity'

local invaderBullet = Class{
  __includes = Entity -- Player class inherits our Entity class
}

function invaderBullet:init(x, y)
  
  self.img = love.graphics.newImage('img/invaderBullet.png')
  self.speed = invaderBulletSpeed
  Entity.init(self, 'invaderBullet', x, y, self.img:getWidth(), self.img:getHeight())
  
end

function invaderBullet:update(dt)
    
  self.y = self.y + (self.speed * dt)
  if self.y > love.graphics.getHeight() then -- remove bullets when they pass off the screen
    Entities:remove(self)
  end
  
end

function invaderBullet:draw()
  
  love.graphics.draw(self.img, self.x, self.y)
  
end

return invaderBullet