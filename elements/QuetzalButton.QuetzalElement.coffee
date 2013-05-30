class window.QuetzalButton extends QuetzalElement

  style: """
    button {
      background: none; /* Better to start with no background than a browser-dependent one. */
      border: none; /* Many button styles don't want a border by default. */
      box-sizing: border-box;
      color: inherit; /* Suppress browser's use of special button text color. */
      cursor: default;
      /* cursor: pointer; */ /* Improves consistency */
      font: inherit;
      margin: 0; /* Addresses margins set differently in IE6/7, FF3+, S5, Chrome */
      text-align: left; /* Many more things behave like buttons than want to be center-aligned like a stock button. */
      -webkit-user-select: none;
      -moz-user-select: none;
      vertical-align: baseline; /* Improves appearance and consistency in all browsers */
    }

    /* &.generic */
    button {
      background: whitesmoke;
      background-image: -webkit-linear-gradient(top, white, #e6e6e6);
      background-image: linear-gradient(top, white, #e6e6e6);
      border: 1px solid #ccc;
      border-radius: 3px;
      box-shadow: inset 0 1px 0 rgba(255, 255, 255, .2), 0 1px 2px rgba(0, 0, 0, .05);
      color: #333;
      padding: 0.3em 0.6em;
      text-align: center;
      text-shadow: 0 1px 1px rgba(255,255,255,.75);
      white-space: nowrap;
      vertical-align: middle;
    }

    button:hover {
      background-color: #e6e6e6;
      background-image: -webkit-linear-gradient(top, white, #eee);
      background-image: linear-gradient(top, white, #eee);
      border-bottom-color: #ccc;
      border-left-color: #ddd;
      border-right-color: #ddd;
      border-top-color: #e0e0e0;
      color: #222;
      text-shadow: 0 1px 3px white;
    }

    button:active {
      background-color: #d9d9d9;
      background-image: none;
      border-color: #aaa;
      box-shadow: inset 0 1px 4px 2gba(0, 0, 0, 0.15), 0 1px 2px rgba(0, 0, 0, 0.05);
      color: #111;
      filter: none;
      outline: 0;
    }

    button[disabled] {
      background: whitesmoke;
      border: 1px solid #ccc;
      box-shadow: none;
      color: #999;
      cursor: default; /* Re-set default cursor for disabled buttons */
      text-shadow: none;
    }

    /* For now, workaround shadow button click bug by giving huge margin. */
    button {
      padding: 1em;
    }
  """

  template: [
    button: [
      content: []
    ]
  ]

  @register()
