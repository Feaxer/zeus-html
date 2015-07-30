os = require("os")
class Html
    tags: "a article aside b body button canvas caption dd dt div em fieldset figcaption figure footer form h1 h2 h3 h4 h5 h6 head header html i label legend li map nav ol option p pre script section select span style sub sup table tbody td textarea tfoot th thead title tr ul".split " "
    stags: "br meta link area hr img input".split " "
    tabs_size: 4
    tabs_to_spaces: false

    constructor: (@buffer = false, @ident = 0) ->
        @output = '' if @buffer
        @defineTag tagname for tagname in @tags
        @defineStag tagname for tagname in @stags

    defineTag: (tagname) ->
        @[tagname] = (attrs, content) ->
            @tag tagname, attrs, content 

    defineStag: (tagname) ->
        @[tagname] = (attrs) ->
            @stag tagname, attrs

    tabs: ->
        Array(@ident+1).join(if @tabs_to_spaces then Array(@tabs_size+1).join(' ') else "\t")

    attributes: (attrs) -> 
        html = if attrs? then ("#{attr}='#{value}'" for attr, value of attrs).join(' ') else ''
        if html.length > 0 then " "+html else ''

    tag: (tag, attrs, content) ->
        if typeof content == 'function'
            inner_html = new Html(true, @ident+1)
            inner_html.tabs_to_spaces = @tabs_to_spaces
            inner_html.tabs_size = @tabs_size
            content(inner_html)
            inner = os.EOL + inner_html.output + @tabs()
        else inner = content ? ''
        html = "<#{tag}#{@attributes(attrs)}>#{inner}</#{tag}>"
        @output += @tabs() + html+os.EOL if @buffer
        html unless @buffer

    stag: (tag, attrs) -> 
        html = "<#{tag}#{@attributes(attrs)}>"
        @output += @tabs() + html+os.EOL if @buffer
        html unless @buffer

    raw: (text) ->
        @output += @tabs() + text + os.EOL if @buffer
        text unless @buffer

module.exports = (buf = false, ident = 0) ->
    new Html(buf, ident)