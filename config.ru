require "gollum/app"

Precious::App.set(:gollum_path, File.dirname(__FILE__))
Precious::App.set(:wiki_options, {})
run Precious::App

