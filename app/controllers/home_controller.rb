
class HomeController < ApplicationController
  def search
    key = params[:search]
    search = Word.where('rumi LIKE ?', "#{key}%").order(:rumi).includes(:extendeds, :examples)

    results = []
    search.each do |word|      
      result = word.attributes
      result['extendeds'] = word.extendeds
      result['examples'] = word.examples
      
      results << result
    end
    render json: { result: results.to_json }
  end

end
