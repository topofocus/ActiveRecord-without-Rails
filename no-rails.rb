$:.unshift File.expand_path('.')
require 'config/boot'

Page.destroy_all
Page.create
puts Page.all.inspect

if __FILE__ == $0
  puts "Count of Pages: #{Page.count}"
end
