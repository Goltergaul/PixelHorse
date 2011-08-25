class ph.AssetManager
  @assets = {}
  
  @addAsset: (asset, id) ->
    if @assets[id]
      throw "Error: Asset ID already taken!"
    @assets[id] = asset
    return asset
    
  @getAsset: (id) ->
    if not @assets[id]
      throw "Error: Asset with ID #{id} not found!"
      
    return @assets[id]
