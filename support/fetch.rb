#!/usr/bin/env ruby

require 'rainbow'

url_prefix = 'https://raw.githubusercontent.com'

javascripts = [
  'rails/jquery-ujs/master/src/rails.js',
  'http://code.jquery.com/jquery-2.1.3.js',
  'rmm5t/jquery-timeago/master/jquery.timeago.js',
  'codemirror/CodeMirror/master/lib/codemirror.js',
  'codemirror/CodeMirror/master/mode/markdown/markdown.js',
  'blueimp/jQuery-File-Upload/master/js/jquery.fileupload.js',
  'blueimp/jQuery-File-Upload/master/js/vendor/jquery.ui.widget.js',
  'blueimp/jQuery-File-Upload/master/js/jquery.iframe-transport.js'
]

stylesheets = [
  'codemirror/CodeMirror/master/lib/codemirror.css',
  'colebemis/feather/master/webfont/feather-webfont/feather.css'
]

javascripts.each_index do |index|
  javascript = javascripts[index]
  unless javascript.match /^http/
    javascripts[index] = "#{url_prefix}/#{javascript}"
  end
end

stylesheets.each_index { |index| stylesheets[index] = "#{url_prefix}/#{stylesheets[index]}" }

webfonts = []

['eot', 'svg', 'ttf', 'woff'].each do |webfont|
  webfonts << "#{url_prefix}/colebemis/feather/master/webfont/feather-webfont/fonts/feather-webfont.#{webfont}"
end

pwd = Dir.pwd

assets_dir = "#{pwd}/support/assets"

def pull(url, target)
  puts Rainbow("==> ").cyan + Rainbow("Downloading #{url}").white.bright
  system("wget #{url} -q -O #{target}")
  puts Rainbow("==> ").cyan + Rainbow("See #{target}").green
end

javascripts.each do |javascript|
  basename = File.basename(javascript).gsub(/\-[0-9]\.[0-9]\.[0-9]/, '')
  unless File.exist?("#{assets_dir}/javascripts/#{basename}")
    pull(javascript, "support/assets/javascripts/#{basename}")
  end
end

stylesheets.each do |stylesheet|
  basename = File.basename(stylesheet).gsub(/\.css/, '.scss').gsub(/jquery\./, '').gsub(/font-/, '')
  unless File.exist?("#{assets_dir}/stylesheets/#{basename}")
    pull(stylesheet, "support/assets/stylesheets/#{basename}")
  end
end

webfonts.each do |webfont|
  basename = File.basename(webfont)
  unless File.exist?("#{pwd}/static/assets/fonts/#{basename}")
    pull(webfont, "static/assets/fonts/#{basename}")
  end
end
