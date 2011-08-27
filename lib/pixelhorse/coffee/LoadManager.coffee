class ph.LoadManager

  getOverallPercentLoaded: () ->
    ph.Loadable.getLoadingPercent()
        
  monitorLoading: (updateCallback = null) =>
    if updateCallback && typeof(updateCallback) is "function"
      @updateCallback = updateCallback
    percent = @getOverallPercentLoaded()
    @updateCallback(percent)
    if percent >= 100
      event = document.createEvent("UIEvents")
      event.initEvent("AssetsLoaded", true, true)
      document.dispatchEvent(event);
    else
      window.setTimeout(@monitorLoading, 100)