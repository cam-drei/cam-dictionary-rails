class HomeController < ApplicationController
    def search
        @key = params[:search]
        # debugger 
        @search = ImportData.where('rumi LIKE ?', "#{@key}%").includes(:extendeds)
        # @search = ImportData.where('rumi LIKE ?', "#{@key}%").limit(50)

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
            result["description"]["english"] = word.english
            result["description"]["pronunciation"] = word.pronunciation
            # result["description"]["fullDescription"] = word.fullDescription
            fullList = []
            word.extendeds.each do |ex|
                list ={}
                list["list"] = ex.rumi.to_s + " " + ex.akharThrah.to_s + " " + ex.vietnamese.to_s + " _ " + ex.french.to_s + " " + ex.english.to_s + " " + ex.pronunciation.to_s + " " + ex.fullDescription.to_s + " " + ex.source.to_s
                fullList << list
            end
            # debugger
            # result["description"]["fullDescription"] = []
            # fullList.each do |li|
            #     # debugger
            #     result["description"]["fullDescription"] << li["list"]
            # end
            
            result["description"]["fullDescription"] = fullList.to_json
            @results << result
            # debugger
            # end
        end
        # debugger

        render json: {result: @results.to_json}

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