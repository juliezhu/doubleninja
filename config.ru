#ENV['GEM_HOME'] = '/home/juliezhu/.gems'
#ENV['GEM_PATH'] = '/home/juliezhu/.gems' + ':/usr/lib/ruby/gems/1.8'
#require '/home/juliezhu/.gems/gems/sinatra-1.1.0/lib/sinatra.rb'
# require ::File.expand_path('./../dreamdesign', __FILE__)

require "./dreamy"

run Sinatra::Application
