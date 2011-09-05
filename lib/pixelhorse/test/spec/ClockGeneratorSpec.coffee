describe "ClockGenerator", () ->
  callbacks = clock = null
  
  beforeEach () ->
    callbacks = 
      update: () ->
      draw: () -> 
    clock = new ph.ClockGenerator(callbacks.update, callbacks.draw)
    
  afterEach () ->
    clock.stop()
  
  it "should construct correct", () ->
    expect(clock.averageDt).toEqual(0)
    
  describe "start()", () ->
    
    it "should start cycling", () ->
      spyOn(window, "setInterval")
      clock.start()
      expect(window.setInterval).toHaveBeenCalledWith(clock.cycle, 30)
      expect(clock.stopped).toBeFalsy()

  describe "cycle()", () ->
    
    it "should call update and draw", () ->
      spyOn(clock, "update")
      spyOn(clock, "draw")
      clock.start()
      
      waitsFor () ->
        clock.update.wasCalled
      runs () ->
        expect(clock.update).toHaveBeenCalled()
        expect(clock.draw).toHaveBeenCalled()
        expect(clock.averageDt).toNotBe(0)
        
  describe "stop()", () ->
    
    it "should stop cycling", () ->
      spyOn(clock, "update")
      clock.start()
      clock.stop()
      clock.update.reset()
      
      waits(100)
      
      runs () ->
        expect(clock.update).not.toHaveBeenCalled()
