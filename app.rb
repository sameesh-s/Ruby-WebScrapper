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
    heading = doc.css("h1,h2,h3,h4").map{|i| [i.name,i.text.strip]}
    res = {}
    res['h1']=heading.select{|i| i[0]=="h1"}.map{|i| i[1]}
    res['h2']=heading.select{|i| i[0]=="h2"}.map{|i| i[1]}
    res['h3']=heading.select{|i| i[0]=="h3"}.map{|i| i[1]}
    res['h4']=heading.select{|i| i[0]=="h4"}.map{|i| i[1]}
    res['links']=links.select{|i| i[0]=='h'}
    content_type :json
      JSON.pretty_generate res
  end