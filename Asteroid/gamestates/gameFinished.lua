gameFinished = Gamestate.new()

function gameFinished:enter(from)
  self.from = from -- record previous state
end

function gameFinished:draw()
  local w, h = love.graphics.getWidth(), love.graphics.getHeight()

  -- overlay with pause message
  love.graphics.setColor(0,0,0, 100)
  love.graphics.rectangle('fill', 0,0, w, h)
  love.graphics.setColor(255,255,255)
  love.graphics.printf('GAME FINISHED', 0, h/2, w, 'center')
end


return gameFinished