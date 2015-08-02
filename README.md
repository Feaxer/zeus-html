# Zeus Html
Simple nodejs html generator written on coffee-script 

## Instalation
```sh
npm install zeus-html --save
```
## Usage
##### 
###### JavaScript

```js
var html = require("zeus-html")(true)

html.div({class: "form-group"}, function(fg){
    fg.label({}, "Text field: ")
    fg.input({type: "text", class: "form-control"})
})

html.div({class: "form-group"}, function(fg){
    fg.label({}, function(label){
        label.raw("Required text field: ")
        label.span({class: "required"}, "*")
    })
    fg.input({type: "text", class: "form-control", required: true})
})

html.button({type: "submit", class: ["btn", "btn-default"]}, "Submit")

console.log(html.output)
```
###### HTML
```html
<div class='form-group'>
        <label>Text field: </label>
        <input type='text' class='form-control'>
</div>
<div class='form-group'>
        <label>
                Required text field:
                <span class='required'>*</span>
        </label>
        <input type='text' class='form-control' required>
</div>
<button type='submit' class='btn btn-default'>Submit</button>
```

