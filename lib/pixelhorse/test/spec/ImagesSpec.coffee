describe "Images", () ->
  
  describe "load()", () ->
    
    it "should increase the load count", () ->
      spyOn(ph.LoadManager, "increaseLoadCount")
      ph.Images.load("fixtures/dummy.jpg")
      
      expect(ph.LoadManager.increaseLoadCount).toHaveBeenCalled()

    it "should increase the loaded count once the file is loaded", () ->
      spyOn(ph.LoadManager, "increaseLoadedCount")
      image = ph.Images.load("fixtures/dummy.jpg")
      
      expect(image instanceof window.Image).toBeTruthy()
      expect(image.src).toMatch(/.*fixtures\/dummy.jpg$/)
      
      waitsFor () ->
        ph.LoadManager.increaseLoadedCount.wasCalled
        
    it "should call the callback once the image has loaded", () ->
      callbacks = 
        loaded: () ->
      spyOn(callbacks, "loaded")
      ph.Images.load("fixtures/dummy.jpg", callbacks.loaded)

      waitsFor () ->
        callbacks.loaded.wasCalled