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
    wines_b = rest_resource_b.get
    #will get back you all the detail in json format, but it will we wraped as string, so we will parse it in the next step.
    @wines = JSON.parse(wines,:symbolize_names => true) 
     @wines_b = JSON.parse(wines_b,:symbolize_names => true) 
    # we will convert the return  data into array of hash.see json data parsing here

  end
end
