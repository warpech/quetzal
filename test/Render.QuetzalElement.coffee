test "Render: empty element", ->
  div = document.createElement "div"
  renderEqual2 div, ""

test "Render: element with text content", ->
  span = document.createElement "span"
  span.textContent = "Hello"
  renderEqual2 span, "Hello"

test "Render: element with attributes", ->
  div = document.createElement "div"
  span = document.createElement "span"
  span.setAttribute "foo", "one"
  span.setAttribute "bar", "two"
  div.appendChild span
  renderEqual2 div, "<span foo=\"one\" bar=\"two\"></span>"

test "Render: element with child elements", ->
  div = document.createElement "div"
  div.innerHTML = "<span>Hello,</span> <span>world.</span>"
  renderEqual2 div, "<span>Hello,</span> <span>world.</span>"

test "Render: element with shadow", ->
  div = document.createElement "div"
  div.innerHTML = "This shouldn't be rendered"  
  root = div.webkitCreateShadowRoot()
  root.innerHTML = "<div>Shadow</div>"
  renderEqual div, "<div>Shadow</div>"
  renderEqual2 div, "<div>Shadow</div>"

test "Render: element with shadow with content", ->
  div = document.createElement "div"
  div.innerHTML = "OK"  
  root = div.webkitCreateShadowRoot()
  root.innerHTML = "<button><content></content></button>"
  renderEqual div, "<button>OK</button>"
  renderEqual2 div, "<button>OK</button>"
