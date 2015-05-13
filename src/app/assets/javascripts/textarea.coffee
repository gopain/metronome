$ ->
  textarea = $ 'textarea.markdown'

  if textarea.length
    CodeMirror.fromTextArea textarea[0], {
      mode  : 'markdown'
      cursorHeight: 1.65
    }
