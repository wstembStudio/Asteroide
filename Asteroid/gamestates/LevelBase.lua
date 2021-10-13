-- Each level will inherit from this class which itself inherits from Gamestate.
-- This class is Gamestate but with function for loading up Tiled maps.

local Gamestate = require 'libs.hump.gamestate'
local Class = require 'libs.hump.class'
local Entities = require 'entities.Entities'

local Player = require 'entities.Player'
local Invader = require 'entities.Invader'

score = 0
lifes = 3

local LevelBase = Class{
  __includes = Gamestate,
  init = function(self)
    Entities:enter()
  end;
}

function LevelBase:enter()
  levelScore = 0
  invaderTimer = 0
  invaderCount = 0
  player = Player()
  Entities:add(player)
end

function LevelBase:update(dt)
  
  if (lifes <= 0) then
    Gamestate.switch(gameover)
    return
  end
  
  invaders = Entities:getEntities('invader')
  if (invaderCount > 0 and table.getn(invaders) <= 0) then
    Gamestate.switch(levelFinished)
  end
  
  if invaderCount < invaderLevelCount then
    x = math.random(0,love.graphics.getWidth())
    y = 0
    newInvader = Invader(x, y, canShootTimerMax)
    invaderTimer = invaderTimer + dt
    if (invaderTimer >= invaderLevelTimer) then -- un invader arrive tous les invaderTimer sec
      Entities:add(newInvader)
      invaderCount = invaderCount + 1
      invaderTimer = 0;
    end
  end
  
  Entities:update(dt)
  updateCollisions()

end

function LevelBase:draw()
  love.graphics.draw(spaceImg, 0, 0, 0, love.graphics:getWidth()/spaceImg:getWidth(), love.graphics:getHeight()/spaceImg:getHeight())
  love.graphics.print("Score=" .. score , 0, 0)
  love.graphics.print("Level" .. level .. " Score=" .. levelScore , 0, 25)
  
  lifeImg = love.graphics.newImage('img/coeur.png')
  for i=1,lifes do
    love.graphics.draw(lifeImg,love.graphics:getWidth()-i*lifeImg:getWidth(),0)
  end
  
  --LevelBase.Entities:draw()
  Entities:draw()
end

function LevelBase:keypressed(key)
  -- All levels will have a pause menu
  if Gamestate.current() ~= pause and key == 'p' then
    Gamestate.push(pause)
  end
end

function updateCollisions()
  invaders = Entities:getEntities('invader')
  playerBullets = Entities:getEntities('playerBullet')
  invaderBullets = Entities:getEntities('invaderBullet')
  
  -- invaders et bullets
  for i, invader in ipairs(invaders) do
    for j, bullet in ipairs(playerBullets) do
      collision = CheckCollision(invader.x, invader.y, invader.img:getWidth(), invader.img:getHeight(), bullet.x, bullet.y, bullet.img:getWidth(), bullet.img:getHeight())
      if (collision == true) then
        Entities:remove(invader)
        Entities:remove(bullet)
        score = score + invader.score
        levelScore = levelScore + invader.score
      end
    end
  end
  
  -- canon et invaders
  for i, invader in ipairs(invaders) do  
    collision = CheckCollision(invader.x, invader.y, invader.img:getWidth(), invader.img:getHeight(), player.x, player.y, player.img:getWidth(), player.img:getHeight())
    if (collision == true) then
      Entities:remove(invader)
      --Entities:remove(player)
      lifes = lifes - 1
    end
  end
  
  -- canon et invaderBullets
  for i, invaderBullet in ipairs(invaderBullets) do  
    collision = CheckCollision(invaderBullet.x, invaderBullet.y, invaderBullet.img:getWidth(), invaderBullet.img:getHeight(), player.x, player.y, player.img:getWidth(), player.img:getHeight())
    if (collision == true) then
      Entities:remove(invaderBullet)
      --Entities:remove(player)
      lifes = lifes - 1
    end
  end
  
end

function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

return LevelBase