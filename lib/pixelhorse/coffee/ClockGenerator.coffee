class ph.ClockGenerator
 
  constructor: (@updateCallback, @drawCallback) ->
    @averageDt = 0
  
  start: () ->
    @stopped = false
    date = new Date
    @lastFrameTime = date.getTime()
    @cycle()
    @intervalId = window.setInterval(@cycle, 30)
   
  cycle: () =>
    date = new Date
    now = date.getTime()
    dt = now - @lastFrameTime
    @update(dt)
    @draw(dt)
    @averageDt = (@averageDt + dt) / 2
    @lastFrameTime = now
    if @stopped
      window.clearInterval(@intervalId)
      
  stop: () ->
    @stopped = true
    
  update: (dt) ->
    @updateCallback(dt)
    
  draw: (dt) ->
    @drawCallback(dt)
    window.requestAnimationFrame       || 
    window.webkitRequestAnimationFrame || 
    window.mozRequestAnimationFrame    || 
    window.oRequestAnimationFrame      || 
    window.msRequestAnimationFrame     || null
    
