# frozen_string_literal: true

class HomeController < ApplicationController
  def search
    key = params[:search]
    search = Word.where('rumi LIKE ?', "#{key}%").order(:rumi).includes(:extendeds, :examples)

    results = []
    search.each do |word|
      result = word.attributes.slice('akharThrah', 'rumi')
      result['extendeds'] = word.extendeds
      #   result['title'] = word.rumi
      #   result['description'] = {}
      #   result['description']['akharThrah'] = word.akharThrah
      #   result['description']['source'] = word.source
      #   result['description']['pronunciation'] = word.pronunciation

      fullMeaning = build_extendeds(word)

      result['description']['fullDescription'] = fullMeaning.to_json
      results << result
    end

    render json: { result: results.to_json }
  end

  private

  def build_extendeds(word)
    fullMeaning = []
    word.extendeds.each do |exten|
      @meaning = {}
      @meaning['meaning'] = exten

      build_examples(exten)
      fullMeaning << @meaning
    end
    fullMeaning
  end

  def build_examples(exten)
    @meaning['list'] = []
    exten.examples.each do |exam|
      @meaning['list'] << exam
    end
  end
end
