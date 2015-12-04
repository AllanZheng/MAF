class WinesController < ApplicationController
	  require 'rest_client'
	   SEVER1_BASE_URL = "http://localhost:3000" # base url of the API
     SEVER2_BASE_URL = "http://localhost:3001" # base url of the API
  def index
    uri = "#{SEVER1_BASE_URL}/wines.json" # specifying json format in the URl
    uri_b = "#{SEVER2_BASE_URL}/wines.json" # specifying json format in the URl
    rest_resource = RestClient::Resource.new(uri) 
    rest_resource_b = RestClient::Resource.new(uri_b) 
    #It will create new rest-client resource so that we can call different methods of it
    wines = rest_resource.get 
    #jpg = rest_resource.get, :accept => 'image/jpg'
    wines_b = rest_resource_b.get
    #will get back you all the detail in json format, but it will we wraped as string, so we will parse it in the next step.
    #@jpg = JSON.parse(jpg,:symbolize_names => true) 
    @wines = JSON.parse(wines,:symbolize_names => true) 
    @wines_b = JSON.parse(wines_b,:symbolize_names => true) 
    # we will convert the return  data into array of hash.see json data parsing here
    #session[:wines]=@wines
    #session[:wines_b]=@wines_b
   @wines=@wines+@wines_b
   @wines.sort!{|a,b| a[:Price].downcase <=> b[:Price].downcase}
   @wines.uniq!{|a| a[:Title]}
   @wines.sort!{|a,b| a[:Title].downcase <=> b[:Title].downcase}

    
  end

  def show
    puts params[:wine_id]
    #if(params[:wine][:Company]=='server2')
  	uri = "#{SEVER1_BASE_URL}/wines/#{params[:wine_id]}.json" # specifying format as json so that  
    #else                                                #json data is returned 
    #uri = "#{SEVER2_BASE_URL}/wines/#{params[:wine_id]}.json"
  #end
    rest_resource = RestClient::Resource.new(uri)
    w = rest_resource.get
    @w = JSON.parse(w, :symbolize_names => true)
  end

  def search

  end

end
