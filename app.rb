#!/usr/bin/env ruby

require 'sinatra'
  get '/app' do
    '<form action="/result">
      <input type="text" name="title" />
      <input type="submit" name="submit" />
    </form>'
  end

  get '/result' do
    '<h1>Result</h1>'+params[:title].to_s
  end
