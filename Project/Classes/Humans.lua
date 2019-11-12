local Actor = Actor or require "Lib/actor"
local Human = Actor:extend()

math.randomseed(os.clock())

function Human:new(player)
  Human.super.new(self, "Resources/humanSample.png", 700, 600, 200)
end

function Human:update(dt)

  Human.super.update(self,dt)
  if(sceneItems.gameController.phase == 1) then
      Human.super.update(self,dt)
    Human.chasing(self)
  elseif(sceneItems.gameController.phase == 2) then
    Human.scaping(self)
  end
  
   
   
end

function Human:write()
  Human.super.draw(self)
end 

function Human:scaping()
  
  self.forward.x = math.random(-1,1)
  self.forward.y = math.random(-1,1)
  
  self.rot = math.acos(self.forward.x)
  
  if(self.position.x > love.graphics.getWidth())then
    self.position.x = 1
  elseif(self.position.x < 0) then
    self.position.x = love.graphics.getWidth() -1
  elseif(self.position.y < 200) then
    self.position.y = love.graphics.getHeight() -1
  elseif(self.position.y > love.graphics.getHeight()) then
    self.position.y = 201
  end
end

function Human:chasing()
  local dist1 = sceneItems.char1.position.distance(sceneItems.char1.position, self.position)
  local dist2 = sceneItems.char2.position.distance(sceneItems.char2.position, self.position)

  if(dist1 <= dist2) then
    Human.chaseEnemy(self, sceneItems.char1.position)
  elseif(dist2 < dist1) then
    Human.chaseEnemy(self, sceneItems.char2.position)
  end
  
  if(Human.super.intersect(self,sceneItems.char1)) then
    self.delete = true
  elseif(Human .super.intersect(self, sceneItems.char2)) then
    self.delete = true
  end  
end


function Human:chaseEnemy(b)
  local angle = math.atan2((b.x - self.position.x), (b.y - self.position.y)) 
  
    self.rot = -(angle)
		self.forward.x = math.sin(angle)
		self.forward.y = math.cos(angle)
end

return Human


