class HomeController < ApplicationController
    def search
        @key = params[:search]
        # debugger 
        @search = ImportData.where('rumi LIKE ?', "#{@key}%").limit(10)
        
        # h = Hash.new

        @results = []
        @search.each do |result|
            # debugger
            h = {}
            h["title"] = result.rumi
            h["description"] = result.vietnamese
            @results << h
            # debugger
        end
        # debugger

        render json: {result: @results.to_json}

        # @search = ImportData.where(:rumi => @key)
        # debugger  
    end
end
