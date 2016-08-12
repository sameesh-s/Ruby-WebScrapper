#!/usr/bin/env ruby
require 'sinatra'
require 'nokogiri'
require 'open-uri'


  get '/app' do
    '<form action="/result" method="POST">
      <input type="text" name="title" />
      <input type="submit" name="submit" />
    </form>'
  end

  post '/result' do
    doc = Nokogiri::HTML open (params[:title].to_s)
    links = doc.css("a").map{ |i| i["href"]}
    heading = doc.css("h1,h2,h3,h4").map{ |i| i.name+":"+i.text }
    arr = links.select{|i| i[0]=='h'}
    '<h1>Headings</h1>'+heading.join('<br>')+'<br><h1>Links</h1>'+arr.join("<br>")
  end
