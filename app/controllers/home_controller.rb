class HomeController < ApplicationController
    def search
        @key = params[:search]
        # debugger 
        @search = Word.where('rumi LIKE ?', "#{@key}%").includes(:extendeds, :examples)
        # @search = Word.where('rumi LIKE ?', "#{@key}%").limit(50)

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
            fullMeaning = []
            word.extendeds.each do |exten|
                meaning ={}
                # meaning["meaning"] = exten.wordClasses.to_s + " " + exten.rumi.to_s + " " + exten.akharThrah.to_s + " " + exten.source.to_s + " " + exten.vietnamese.to_s + " = " + exten.french.to_s + " _ " + exten.english.to_s + " " + exten.pronunciation.to_s + " " + exten.fullDescription.to_s
                meaning["meaning"] = {}
                meaning["meaning"]["wordClasses"] = exten.wordClasses
                meaning["meaning"]["rumi"] = exten.rumi
                meaning["meaning"]["akharThrah"] = exten.akharThrah
                meaning["meaning"]["source"] = exten.source
                meaning["meaning"]["vietnamese"] = exten.vietnamese
                meaning["meaning"]["french"] = exten.french
                meaning["meaning"]["english"] = exten.english
                meaning["meaning"]["pronunciation"] = exten.pronunciation
                meaning["meaning"]["fullDescription"] = exten.fullDescription
                

                meaning["list"] = []
                exten.examples.each do |exam|
                    # example = exam.rumi.to_s + " " + exam.akharThrah.to_s + " " + exam.source.to_s + " " + exam.vietnamese.to_s + " = " + exam.french.to_s + " _ " + exam.english.to_s + " " + exam.pronunciation.to_s + " " + exam.fullDescription.to_s
                    example = {}
                    example["rumi"] = exam.rumi
                    example["akharThrah"] = exam.akharThrah
                    example["source"] = exam.source
                    example["vietnamese"] = exam.vietnamese
                    example["french"] = exam.french
                    example["english"] = exam.english
                    example["pronunciation"] = exam.pronunciation
                    example["fullDescription"] = exam.fullDescription
                    
                    # debugger
                    meaning["list"] << example
                end

                fullMeaning << meaning
                # debugger
            end


            # debugger
            # result["description"]["fullDescription"] = []
            # fullMeaning.each do |li|
            #     # debugger
            #     result["description"]["fullDescription"] << li["meaning"]
            # end
            
            result["description"]["fullDescription"] = fullMeaning.to_json
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