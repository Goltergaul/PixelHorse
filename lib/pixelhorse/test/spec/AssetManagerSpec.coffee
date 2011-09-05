describe "Asset Manager", () ->
  
  describe "addAsset()", () ->
    
    it "should throw an error if no id is specified", () ->
      expect(() -> ph.AssetManager.addAsset({})).toThrow("fatalError")

    it "should throw an error if an asset ID is already taken", () ->
      ph.AssetManager.addAsset({}, "a")
      expect(() -> ph.AssetManager.addAsset({}, "a")).toThrow("fatalError")

  describe "getAsset()", () ->
    
    it "should throw an error if asset with id does not exist", () ->
      expect(() -> ph.AssetManager.getAsset("b")).toThrow("fatalError")
      
    it "should return the right asset", () ->
      ph.AssetManager.addAsset({id: 1}, "c")
      ph.AssetManager.addAsset({id: 2}, "d")
      ph.AssetManager.addAsset({id: 3}, "e")
      
      expect(ph.AssetManager.getAsset("d")).toEqual({id: 2})
