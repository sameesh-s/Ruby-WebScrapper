#!/usr/bin/env ruby
require 'sinatra'
require 'nokogiri'
require 'open-uri'
require 'json'


  get '/app' do
    '<form action="/result" method="POST">
      <input type="text" name="title" />
      <input type="submit" name="submit" />
    </form>'
  end

  post '/result' do
    doc = Nokogiri::HTML open (params[:title].to_s)
    links = doc.css("a").map{ |i| i["href"]}
    heading = doc.css("h1,h2,h3,h4").map{|i| i}
    res = {}
    res['h1']=heading.select{|i| i.name=="h1"}.map{|i| i.text.strip}
    res['h2']=heading.select{|i| i.name=="h2"}.map{|i| i.text.strip}
    res['h3']=heading.select{|i| i.name=="h3"}.map{|i| i.text.strip}
    res['h4']=heading.select{|i| i.name=="h4"}.map{|i| i.text.strip}
    res['links']=links.select{|i| i[0]=='h'}

    File.open('headers_links.json', 'w') do |f|
      f.puts res.to_json
    end
    content_type :json
    File.read('headers_links.json')
  end
