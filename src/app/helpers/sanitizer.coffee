module.exports = (html) ->
  (require 'sanitize-html') html, {
    selfClosing    : 'img:br:hr:area:base:basefont:input:link:meta'.split ':'
    allowedTags    : 'h1:h2:h3:h4:h5:h6:blockquote:ul:ol:li:p:a:b:i:strong:em:strike:pre:code:img:hr:br:div:table:thead:tbody:tr:th:td:caption'.split ':'
    allowedSchemes : 'http:https:mailto:git'.split ':'

    allowedAttributes:
      a   : 'href:name:target:data-*'.split ':'
      img : 'src:alt'.split ':'

    allowedClasses:
      a : 'nice:fine'.split ':'
  }
