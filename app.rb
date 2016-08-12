#!/usr/bin/env ruby
require 'sinatra'
require 'nokogiri'
require 'open-uri'

def get_url(domain)
 "https://"+domain
end 

def get_page(address)
  doc = Nokogiri::HTML(open(address)) 
end

  get '/app' do
    '<form action="/result" method="POST">
      <input type="text" name="title" />
      <input type="submit" name="submit" />
    </form>'
  end

  post '/result' do
    doc = get_page get_url(params[:title].to_s)
    links = doc.css("a").map{ |i| i["href"]+'<br>'}.map{|i| i}
    heading = doc.css("h1,h2").map{ |i| i.text+"<br>" }
    '<h1>Headings</h1>'+heading.join+'<br><h1>Links</h1>'+links.join
  end
