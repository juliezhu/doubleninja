require 'rubygems'
require 'sinatra'
require 'open-uri'

def pick_one array
  array[rand(array.size)]
end


def pop_culture_reference
  pick_one ['HalloKitty','Pandemia','LolCatz','War','Financial Meltdown','Pokemon']
end

def generate_object
  pick_one ['bag','lamp','glass','bottle','belt','hat','car','cat','plant','wallpaper','couch','frog','avocado','coffee','apple','hamster','bike','girl']
end

def generate_action
  pick_one [
    'connecting to Twitter',
    'sending email',
    'playing music',
    'playing a video',
    'ordering food',
    'singing'
  ]
end

def generate_how
  pick_one [  
    ['via Arduino','arduino.jpg'],
    ['via MySpace','myspace.jpg'],
    ['via twitter','twitter.jpg'],
    ['via Facebook','facebook.jpg'],
    ['using last.fm','lastfm.jpg'],
    ['by using dopplr','dopplr.png'],
    ['by relying on flickr','flickr.gif'],
    ['with Facebook Connect','facebook.jpg'],
    ['using Google APIs','google1.jpg'],
    ['by using google maps','google2.png'],
    ['via wifi','wifi.jpg'],
    ['using the GPS','gps.jpg'],
    ['via email','email.jpg'],
    ['on your iPhone','iphone.jpg'],
    ['by vibration','vibration.jpg'],
    ['playing a chime','chime.jpg']
  ]
end

def generate_what
  pick_one [
    'to show your emotions',
    'to share love',
    'to impress your friends',
    'to get you fed',
    'to pay your bills',
    'to show you what you need',
    'to radiate happiness',
    'to make you focus',
    'to let you know what is going on',
    ''
  ]
end

get '/testflickr' do

  tags = ['mikamai']
  url = "http://www.flickr.com/search/?w=all&q=#{tags.join('+')}&m=tags"

  html = open(url).read

  @url_imgs = [ ]
  html.gsub /<img src=\"(.*?)\" .*\"pc_img/ do 
    @url_imgs << $1
  end

  haml :oneimage
end

def pick_random_flickr_pic_for tags
  url = "http://www.flickr.com/search/?w=all&q=#{tags.join('+')}&m=tags"

  html = open(url).read

  url_imgs = [ ]
  html.gsub /<img src=\"(.*?)\" .*\"pc_img/ do 
    url_imgs << $1
  end

  return pick_one url_imgs
end

def funky_adjective
  pick_one [
    'Electro', 'Meta', 'Crazy', 'Supa', 'Kinky', 'Nerd', 'Analog', 'Digi', "Wiki", "Tweet",
    'E', 'Cyber', 'Hyper', 'Quasi', 'Sudo', 'Web', 'Uber', 'Cloud', 'i', 'DIY', 'Neuro', 'Psy', "Think", 'Thunder'
  ]
end

def funky_suffix
  pick_one [
    'tron', 'uino', 'OnRails', 'Gears', 'OnWheels', 'ando', 'ino', 'atron','edo','oo','y','ify','Maker','Hack','Tinker',' API', 'Storm'
    ]
end

get '/' do
  item = generate_object().capitalize
  how_sentence, how_file_name = generate_how()

  @description = pick_one [
    "A #{item} #{generate_action} #{how_sentence} #{generate_what}"
    # ,"A #{item} to fight #{pop_culture_reference}"
  ]

  @object_name = pick_one [
                  funky_adjective() + item,
                  item + funky_suffix(),
                  funky_adjective() + item + funky_suffix()
                ]
                
  @picture_url = pick_random_flickr_pic_for [item]
  @concept_url = '/images/'+how_file_name

  erb :index
end

# 
# __END__
# 
# @@ oneimage
# %img{:src=>pick_one(@url_imgs)}
# 
# @@ index
# %html
#   %head
#     %link{:rel => "stylesheet", :href => "/application.css", :type => "text/css", :media => "all"}
#   %body
#     #main
#       #header
#         #content
#           %h1 OLD OLD OLD Design Object of Your Dreams
#           %p you can generate the custom design object you always dreamt of
#           %h2= @object_name
#           %img{:src => @picture_url}
#           %h3 description
#           %p= @description
#     
#     
