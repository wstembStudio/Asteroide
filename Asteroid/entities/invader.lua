-- Import our libraries.
local Gamestate = require 'libs.hump.gamestate'
local Class = require 'libs.hump.class'
local Entities = require 'entities.Entities'
local Entity = require 'entities.Entity'

-- Grab our base class
--local LevelBase = require 'gamestates.LevelBase'

-- Import the Entities we will build.
local InvaderBullet = require 'entities.InvaderBullet'

--invaderCanShoot = true
--invaderCanShootTimerMax = 1
--invaderCanShootTimer = invaderCanShootTimerMax

c2 = 0
changeDirectionTime = math.random(3,10)

local invader = Class{
  __includes = Entity -- Player class inherits our Entity class
}

function invader:init(x, y, canShootTimerMax)
  
  self.speed=20
  self.direction = 'right'
  self.score=1
  self.doubleBullet=false
  self.invaderCanShoot = false
  self.invaderCanShootTimerMax=math.random(1,canShootTimerMax)
  self.invaderCanShootTimer = self.invaderCanShootTimerMax
  
  tmp = math.random(1,21)
  if (tmp == 1) then
    self.img = love.graphics.newImage('img/invader 1.png')
  elseif (tmp == 2) then
    self.img = love.graphics.newImage('img/invader 2.png')
  elseif (tmp == 3) then
    self.img = love.graphics.newImage('img/invader 10.png')
  elseif (tmp == 4) then
    self.img = love.graphics.newImage('img/invader 4.png')
  elseif (tmp == 5) then
    self.img = love.graphics.newImage('img/invader 5.png')
  elseif (tmp == 6) then
    self.img = love.graphics.newImage('img/invader 6.png')
  elseif (tmp == 7) then
    self.img = love.graphics.newImage('img/invader 7.png')
  elseif (tmp == 8) then
    self.img = love.graphics.newImage('img/invader 8.png')
  elseif (tmp == 9) then
    self.img = love.graphics.newImage('img/invader 9.png')
  elseif (tmp == 10) then
    self.img = love.graphics.newImage('img/invader 3.png')
    self.score = 10
    self.doubleBullet = true
  elseif (tmp == 11) then
    self.img = love.graphics.newImage('img/invader 11.png')
    self.score = 10
    self.doubleBullet = true
  elseif (tmp == 12) then
    self.img = love.graphics.newImage('img/invader 14.png')
    self.score = 10
    self.doubleBullet = true
  elseif (tmp == 13) then
    self.img = love.graphics.newImage('img/invader 12.png')
  elseif (tmp == 14) then
    self.img = love.graphics.newImage('img/invader 13.png')
  elseif (tmp == 15) then
    self.img = love.graphics.newImage('img/invader 15.png')
  elseif (tmp == 16) then
    self.img = love.graphics.newImage('img/invader 16.png')
  elseif (tmp == 17) then
    self.img = love.graphics.newImage('img/invader 17.png')
  elseif (tmp == 18) then
    self.img = love.graphics.newImage('img/invader 18.png')
  elseif (tmp == 19) then
    self.img = love.graphics.newImage('img/invader 21.png')
  elseif (tmp == 20) then
    self.img = love.graphics.newImage('img/invader 22.png')
  elseif (tmp == 21) then
    self.img = love.graphics.newImage('img/invader 23.png')
  end
  
  Entity.init(self, 'invader', x, y, self.img:getWidth(), self.img:getHeight())

end

function invader:update(dt)
  
  self.y = self.y + (self.speed * dt)
    
  if self.y >= (love.graphics.getHeight()) then
    Entities:remove(self)
  end

  if self.x <= 0 then
    self.direction = 'right'
    --self.y = self.y + self.img:getHeight()
  end
  if self.x >= (love.graphics.getWidth() - self.img:getWidth()) then
    self.direction = 'left'
    --self.y = self.y + self.img:getHeight()
  end
  if (self.direction == 'right') then
    self.x = self.x + (self.speed * dt)
  elseif (self.direction == 'left') then
    self.x = self.x - (self.speed * dt)
  end
  
  c2 = c2 + dt
  if (c2 >= changeDirectionTime) then
    if (self.direction == 'right') then
      self.direction = 'left'
    elseif (self.direction == 'left') then
      self.direction = 'right'
    end
    c2 = 0
    changeDirectionTime = math.random(3,10)
  end
  
  self.invaderCanShootTimer = self.invaderCanShootTimer - (1 * dt)
  if self.invaderCanShootTimer < 0 then
    self.invaderCanShoot = true
  end
  if self.invaderCanShoot == true then
    if (self.doubleBullet == true) then
      x = self.x - 5 + (self.img:getWidth()/3)
      y = self.y + 15
      invaderBullet = InvaderBullet(x, y)
      Entities:add(invaderBullet)
      x = self.x + 5 + (self.img:getWidth()*2/3)
      y = self.y + 15
      invaderBullet = InvaderBullet(x, y)
      Entities:add(invaderBullet)
    else
      --par défaut
      x = self.x + (self.img:getWidth()/2)
      y = self.y + (self.img:getHeight())
      invaderBullet = InvaderBullet(x, y)
      Entities:add(invaderBullet)
    end
    self.invaderCanShoot = false
    self.invaderCanShootTimer = self.invaderCanShootTimerMax
  end
  
end

function invader:draw()
  love.graphics.draw(self.img, self.x, self.y)  
end

return invader