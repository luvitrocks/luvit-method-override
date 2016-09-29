# method-override

> Middleware for [luvit.io](http://luvit.io) and [Utopia](https://github.com/luvitrocks/luvit-utopia) that lets you use HTTP verbs such as ``PUT`` or ``DELETE`` in places where the client doesn't support it.

## Install

```bash
lit install voronianski/method-override
```

## API

**NOTE** It is very important that this module is used before any module that needs to know the method of the request.

### ``methodOverride(getter)``

Middleware function to override the ``req.method`` property with a new value. This value will be pulled from the provided ``getter``.

### Options

- ``getter`` - the string getter to use to look up the overridden request method for the request, default ``X-HTTP-Method-Override``

### Getter

This is the method of getting the override value from the request. String value should be provided, it is used to look up the method with the following rules:

- if the string starts with ``X-``, then it is treated as the name of a header and that header is used for the method override. If the request contains the same header multiple times, the first occurrence is used

- all other strings are treated as a ``key`` in the URL query string

## Examples

### 1. Override using a header

```lua
local Utopia = require('utopia')
local methodOverride = require('method-override')

local app = Utopia:new()

app:use(methodOverride('X-HTTP-Method-Override'))

app:listen(8080)
```

Example call on client:

```javascript
var xhr = new XMLHttpRequest();
xhr.onload = onload;
xhr.open('POST', '/resource', true);
xhr.setRequestHeader('X-HTTP-Method-Override', 'DELETE');
xhr.send();

function onload () {
  alert('got response: ' + this.responseText);
}
```

### 2. Override using a query value

```lua
local Utopia = require('utopia')
local methodOverride = require('method-override')

local app = Utopia:new()

app:use(methodOverride('_method'))

app:listen(8080)
```

Example call with query override using HTML form:

```html
<form method="POST" action="/resource?_method=DELETE">
	<button type="submit">Delete resource</button>
</form>
```

## License

MIT Licensed

Copyright (c) 2014-2016 Dmitri Voronianski [dmitri.voronianski@gmail.com](mailto:dmitri.voronianski@gmail.com)

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
