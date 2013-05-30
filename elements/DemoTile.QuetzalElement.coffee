class DemoTile extends QuetzalElement

  style: """
    @host {
      * {
        color: #444;
        font-size: 0.9em;
      }
    }

    #container {
      display: inline-block;
      width: 300px;
      vertical-align: top;
    }

    h3 {
      border-top: 2px solid gray;
      color: black;
      font-size: 1.2em;
      padding-top: 0.5em;
    }
  """

  template: """
    <div id="container">
      <h3>
        <markup-tag><content select="property"></content></markup-tag>
      </h3>
      <content></content>
    </div>
  """

  @register()