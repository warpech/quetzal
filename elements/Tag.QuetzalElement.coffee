class MarkupTag extends QuetzalElement

  style: """
    @host {
      * {
        font-family: Courier, Courier New, monospace;
      }
    }
  """

  template: "&lt;<content></content>&gt;"

  @register()
