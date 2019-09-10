class HomeController < ApplicationController
    def search
        @key = params[:search]
        # debugger 
        @search = ImportData.where('rumi LIKE ?', "#{@key}%").limit(10)
        
        # h = Hash.new

        @results = []
        @search.each do |word|
            # debugger
            result = {}
            result["title"] = word.rumi
            result["description"] = {}
            result["description"]["akharThrah"] = word.akharThrah
            result["description"]["source"] = word.source
            result["description"]["vietnamese"] = word.vietnamese
            result["description"]["french"] = word.french
            result["description"]["pronunciation"] = word.pronunciation
            result["description"]["fullDescription"] = word.fullDescription
            @results << result
            # debugger
        end
        # debugger

        render json: {result: @results.to_json}

        # @search = ImportData.where(:rumi => @key)
        # debugger  
    end
end


# @results = []
#         @search.each do |result|
#             # debugger
#             h = {}
#             h["title"] = result.rumi
#             h["description"] = result.vietnamese
#             @results << h
#             # debugger
#         end