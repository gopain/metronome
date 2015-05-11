$('.ui.file').prepend '<span class="icon-cloud-upload"></span><span class="progress-bar"></span>'

$('ul.selector.selectable>li').click (e) ->
  nodeId = $(@).data 'node-id'
  actived = $(@).hasClass 'actived'
  $('.selector.selectable>li').removeClass 'actived'
  $('input[name=node_id]').val nodeId
  unless actived
    $(@).addClass 'actived'

if $('input[name=node_id]').length
  nodeId = $('input[name=node_id]').val()
  $("[data-node-id=#{nodeId}]").addClass 'actived'

if $ '#fileupload' .length
  progressall = (e, data) ->
    progress = parseInt(data.loaded / data.total * 100)
    $ 'span.progress-bar' .css({ width: progress + '%' })
  $ '#fileupload' .fileupload { progressall: progressall }
