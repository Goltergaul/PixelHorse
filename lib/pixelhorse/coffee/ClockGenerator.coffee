###*
 * The ClockGenerator calls your update and draw method at a frequency
 * of ~30 frames per second.
 * 
 * @class
 * @param {function} updateCallback A callback function for your update calls
 * @param {function} drawCallback A callback function for your draw calls
###
class ph.ClockGenerator
 
  ###*
   * @constructs
  ###
  constructor: (@updateCallback, @drawCallback) ->
    @averageDt = 0
  
  ###*
   * Start the clock
   *
   * @memberOf ph.ClockGenerator#
  ###
  start: () ->
    @stopped = false
    date = new Date
    @lastFrameTime = date.getTime()
    @intervalId = window.setInterval(@cycle, 30)
   
  ###*
   * Does one update and draw iteration and calculates the
   * time between the current and the last frame
   *
   * @private
   * @memberOf ph.ClockGenerator#
  ###
  cycle: () =>
    if @stopped
      window.clearInterval(@intervalId)
      return 
    date = new Date
    now = date.getTime()
    dt = now - @lastFrameTime
    @update(dt)
    @draw(dt)
    @averageDt = (@averageDt + dt) / 2
    @lastFrameTime = now
      
  ###*
   * Stops the clock
   *
   * @memberOf ph.ClockGenerator#
  ###
  stop: () ->
    @stopped = true
    
  ###*
   * Calls the update callback
   *
   * @private
   * @memberOf ph.ClockGenerator#
  ###
  update: (dt) ->
    @updateCallback(dt)
    
  ###*
   * Calls the draw callback
   * 
   * @private
   * @memberOf ph.ClockGenerator#
  ###
  draw: (dt) ->
    @drawCallback(dt)
    window.requestAnimationFrame       || 
    window.webkitRequestAnimationFrame || 
    window.mozRequestAnimationFrame    || 
    window.oRequestAnimationFrame      || 
    window.msRequestAnimationFrame     || null
    
