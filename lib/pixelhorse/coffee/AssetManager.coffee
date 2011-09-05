###*
 * The Asset Manager holds every type of object so that it can be
 * acessed by a unique id
 * @class
###
class ph.AssetManager
  @assets = {}
  
  ###*
   * Add an asset
   *
   * @memberOf ph.AssetManager
   * @param {object} asset Any Object
   * @param {string} id An ID
  ###
  @addAsset: (asset, id) ->
    if not id
      throw name: "fatalError", message: "No asset ID specified"
    if @assets[id]
      throw name: "fatalError", message: "Asset ID already taken"
    @assets[id] = asset
    return asset
    
  ###*
   * Get an asset by it's id
   *
   * @memberOf ph.AssetManager
   * @param {string} id An ID
   * @returns {object} object The Object saved under this ID
  ###
  @getAsset: (id) ->
    if not @assets[id]
      throw name: "fatalError", message: "Asset with ID #{id} not found"
      
    return @assets[id]
