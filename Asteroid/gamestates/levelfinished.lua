local gameLevel1 = require 'gamestates.gameLevel1'
local gameLevel2 = require 'gamestates.gameLevel2'
local gameFinished = require 'gamestates.gameFinished'

levelFinished = Gamestate.new()

function levelFinished:enter(from)
  self.from = from -- record previous state
end

function levelFinished:draw()
  local w, h = love.graphics.getWidth(), love.graphics.getHeight()
  -- draw previous screen
  self.from:draw()

  -- overlay with pause message
  love.graphics.setColor(0,0,0, 100)
  love.graphics.rectangle('fill', 0,0, w, h)
  love.graphics.setColor(255,255,255)
  --love.graphics.printf('LEVEL ' .. self.from.level .. ' FINISHED', 0, h/2, w, 'center')
  love.graphics.printf('LEVEL ' .. level .. ' FINISHED', 0, h/2, w, 'center')
end

function levelFinished:keypressed(key)
  -- All levels will have a pause menu
  if key == 'f1' then
    if level == 1 then
      Gamestate.switch(gameLevel2)
    else
      Gamestate.switch(gameFinished)
    end
  end
end


return levelFinished