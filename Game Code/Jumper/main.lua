function love.load()
    wf = require 'libraries/windfield'
    sti = require 'libraries/sti'

    gameEnd = sti( 'maps/mrantDeath.lua' )

    world = wf.newWorld(0, 0)
    love.window.setMode(400, 400)

    

    player = {}
    player.collider = world:newBSGRectangleCollider(0, 0, 45, 35, 20)
    player.collider:setFixedRotation(true)
    player.speed = 250
    player.x = 0
    player.y = 0
    player.sprite = love.graphics.newImage('sprites/mrant.png')

    world:addCollisionClass('Solid')
    world:addCollisionClass('Ghost', {ignores = {'Solid'}})

    enemy = {}
    enemy.collider = world:newBSGRectangleCollider(300, 300, 40, 25, 2)
    enemy.collider:setCollisionClass('Ghost')
    enemy.collider:setFixedRotation(true)
    enemy.speed = 200
    enemy.x = 0
    enemy.y = 0
    enemy.spriteRight = love.graphics.newImage('sprites/lawnmowerright.png')
    enemy.spriteLeft = love.graphics.newImage('sprites/lawnmowerleft.png')

    background = love.graphics.newImage('sprites/ground.png')

    local topWall = world:newRectangleCollider(0, -400, 400, 400)
    topWall:setType('static')
    topWall:setCollisionClass('Solid')

    local rightWall = world:newRectangleCollider(400, 0, 400, 400)
    rightWall:setType('static')
    rightWall:setCollisionClass('Solid')

    local botWall = world:newRectangleCollider(0, 400, 400, 400)
    botWall:setType('static')
    botWall:setCollisionClass('Solid')

    local leftWall = world:newRectangleCollider(-400, 0, 400, 400)
    leftWall:setType('static')
    leftWall:setCollisionClass('Solid')

    timer = 0 
end

function love.update(dt)
    timer = timer + dt

    local vx = 0
    local vy = 0

    local eVX = 0
    local eVY = 0

   if love.keyboard.isDown("d") then
       vx = player.speed
   end
   if love.keyboard.isDown("a") then
       vx = player.speed * -1
   end
   if love.keyboard.isDown("s") then
       vy = player.speed
   end
   if love.keyboard.isDown("w") then
       vy = player.speed * -1
   end

    if love.keyboard.isDown("right") then
        eVX = enemy.speed
    end

    if love.keyboard.isDown("left") then
        eVX = enemy.speed * -1
    end

    if love.keyboard.isDown("down") then
        eVY  = enemy.speed
    end

    if love.keyboard.isDown("up") then
        eVY = enemy.speed * -1
    end

   player.collider:setLinearVelocity(vx, vy)
   enemy.collider:setLinearVelocity(eVX, eVY)

   world:update(dt)

   player.x = player.collider:getX() - 18
   player.y = player.collider:getY() - 15

   enemy.x = enemy.collider:getX() - 40
   enemy.y = enemy.collider:getY() - 50

end

function love.draw()
    love.graphics.draw(background, 0, 0)
    love.graphics.draw(player.sprite, player.x, player.y)
    love.graphics.draw(enemy.spriteRight, enemy.x, enemy.y)
    love.graphics.draw(enemy.spriteLeft, 200, 100)
    world:draw()
end
