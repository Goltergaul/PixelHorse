###*
 * This class loads Images for you and takes track of the
 * percentage of files already loaded through the {@link ph.LoadManager} class.
 * 
 * @class
###
class ph.Images

  ###*
   * Load an image
   *
   * @memberOf ph.Images
   * @param {string} src The image source path
   * @param {function} callback A function to be called once the image is loaded
  ###
  @load: (src, callback) ->
    image = new window.Image()
    ph.LoadManager.increaseLoadCount()
    image.onload = () ->
      if callback
        callback(image)
      ph.LoadManager.increaseLoadedCount()
    image.src = src
    return image
