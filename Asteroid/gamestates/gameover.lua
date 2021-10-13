gameover = Gamestate.new()

function gameover:enter(from)
  self.from = from -- record previous state
end

function gameover:draw()
  local w, h = love.graphics.getWidth(), love.graphics.getHeight()
  -- draw previous screen
  self.from:draw()

  -- overlay with pause message
  love.graphics.setColor(0,0,0, 100)
  love.graphics.rectangle('fill', 0,0, w, h)
  love.graphics.setColor(255,255,255)
  love.graphics.printf('GAME OVER', 0, h/2, w, 'center')
end

function gameover:keypressed(key)
end


return gameover