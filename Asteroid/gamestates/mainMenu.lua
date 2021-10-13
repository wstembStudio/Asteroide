local gameLevel1 = require 'gamestates.gameLevel1'

mainMenu = Gamestate.new()

function mainMenu:enter()
end

function mainMenu:draw()
  local w, h = love.graphics.getWidth(), love.graphics.getHeight()

  -- overlay with pause message
  love.graphics.setColor(0,0,0, 100)
  love.graphics.rectangle('fill', 0,0, w, h)
  love.graphics.setColor(255,255,255)
  love.graphics.printf('MENU', 0, h/2, w, 'center')
end

function mainMenu:keypressed(key)
  if key == 'f1' then
    Gamestate.switch(gameLevel1)
  end
end


return mainMenu