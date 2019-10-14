class HomeController < ApplicationController
    def search
        @key = params[:search]
        @search = Word.where('rumi LIKE ?', "#{@key}%").order(:rumi).includes(:extendeds, :examples)

        @results = []
        @search.each do |word|
            result = {}
            result["title"] = word.rumi
            result["description"] = {}
            result["description"]["akharThrah"] = word.akharThrah
            result["description"]["source"] = word.source
            result["description"]["pronunciation"] = word.pronunciation
            fullMeaning = []
            word.extendeds.each do |exten|
                meaning ={}
                meaning["meaning"] = {}
                meaning["meaning"]["wordClasses"] = exten.wordClasses
                meaning["meaning"]["rumi"] = exten.rumi
                meaning["meaning"]["akharThrah"] = exten.akharThrah
                meaning["meaning"]["source"] = exten.source
                meaning["meaning"]["vietnamese"] = exten.vietnamese
                meaning["meaning"]["french"] = exten.french
                meaning["meaning"]["english"] = exten.english
                
                meaning["list"] = []
                exten.examples.each do |exam|
                    example = {}
                    example["rumi"] = exam.rumi
                    example["akharThrah"] = exam.akharThrah
                    example["source"] = exam.source
                    example["vietnamese"] = exam.vietnamese
                    example["french"] = exam.french
                    example["english"] = exam.english
                    
                    meaning["list"] << example
                end

                fullMeaning << meaning
            end

            
            result["description"]["fullDescription"] = fullMeaning.to_json
            @results << result
        end

        render json: {result: @results.to_json}
    end
end

