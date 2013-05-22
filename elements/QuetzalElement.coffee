###
Quetzal
###

###
Sugar to allow quick creation of element properties.
###
Function::alias = ( propertyName, accessChain, sideEffect ) ->
    processChain = ( obj, propertyName, accessChain, sideEffect, value ) ->
      result = obj
      keys = accessChain.split "."
      setter = ( value isnt undefined) 
      for key, index in keys
        if index == keys.length - 1 and setter
          result[ key ] = value
          result = value
        else
          result = result[ key ]
      if setter and sideEffect?
        sideEffect.call obj, value
      result
    Object.defineProperty @prototype, propertyName,
      enumerable: true
      get: -> processChain @, propertyName, accessChain, sideEffect
      set: ( value ) -> processChain @, propertyName, accessChain, sideEffect, value

Function::getter = ( propertyName, get ) ->
  Object.defineProperty @prototype, propertyName, { get, configurable: true, enumerable: true }

Function::property = ( propertyName, sideEffect ) ->
  Object.defineProperty @prototype, propertyName,
    enumerable: true
    get: -> @._properties[ propertyName ]
    set: ( value ) ->
      @._properties[ propertyName ] = value
      sideEffect?.call @, value

Function::setter = ( propertyName, set ) ->
  Object.defineProperty @prototype, propertyName, { set, configurable: true, enumerable: true }


###
Base Quetzal element class
###
class window.QuetzalElement extends HTMLDivElement

  # REVIEW: Change this so that it's a static function (invoked without "new")?
  constructor: ( element ) ->

    elementClass = @constructor

    unless element instanceof elementClass
      # Make element become an "instanceof" the desired class.
      element.__proto__ = elementClass::

    # TODO: restore styling
    # if elementClass::hasOwnProperty "style"
    #   style = document.createElement "style"
    #   if elementClass::hasOwnProperty "style"
    #     style.innerHTML = elementClass::style
    #   root.appendChild style

    # REVIEW: Always create div? Parse HTML and create document fragment?
    if elementClass::hasOwnProperty "template"

      root = element.webkitCreateShadowRoot()
      wrapper = document.createElement "div"
      wrapper.innerHTML = elementClass::template
      root.appendChild wrapper
      root.applyAuthorStyles = true

      subelementsWithIds = wrapper.querySelectorAll "[id]"
      for subelement in subelementsWithIds
        element.$[ subelement.id ] = subelement

    else
      # Degenerate, no need for wrapper.
      wrapper = null

    baseClass = elementClass.__super__.constructor
    if baseClass is QuetzalElement or baseClass.prototype instanceof QuetzalElement
      wrapper?.classList.add "#{baseClass.name}", "wrapper"
      baseElement = wrapper ? element
      new baseClass baseElement
    element._wrappers[ elementClass.name ] = wrapper

    for key, value of elementClass::inherited
      element[ key ] = value

    if elementClass::hasOwnProperty "ready"
      element.ready()

    return element

  # Holds element references.
  $: {}

  @tagForClass: ( classFn ) ->
    regexWords = /[A-Z][a-z]*/g
    words = classFn.name.match regexWords
    lowercaseWords = ( word.toLowerCase() for word in words )
    lowercaseWords.join "-"

  readyCallback: ->
    new @constructor @

  wrapper: ( elementClass ) ->
    @_wrappers[ elementClass.name ]

  # Holds "private" properties referenced by @property.
  _properties: {}

  # Holds wrapper for each class.
  _wrappers: {}


###
Allow registration of Quetzal element classes with browser.
###
Function::register = ->
  originalClass = @
  className = originalClass.name
  tag = QuetzalElement.tagForClass originalClass
  registeredClass = document.register tag,
    prototype: originalClass::
  # The registered class wraps the original class. Copy public class methods
  # from the original to the wrapped class, and forward the implementations.
  for own methodName, originalImplementation of originalClass when methodName[0] != "_"
    registeredClass[ methodName ] = originalImplementation
  window[ className ] = registeredClass

# Register <quetzal> as an element class
QuetzalElement.register()
