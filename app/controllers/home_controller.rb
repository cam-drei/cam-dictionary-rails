
class HomeController < ApplicationController
  def search
    key = params[:search]
    search = Word.where('rumi LIKE ?', "#{key}%").order(:rumi).includes(:extendeds, :examples)

    results = []
    search.map do |word|    
      result = word.attributes
      result['extendeds'] = word.extendeds
      result['examples'] = build_example(result['extendeds'])  

      results << result
    end
    render json: { result: results.to_json }
  end

  def build_example(extended)
    example = []
    extended.map do |exten|
      example << exten.examples
    end
    example
  end

end
