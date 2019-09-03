class HomeController < ApplicationController
    def search
        @key = params[:search]
        # debugger 
        @search = ImportData.where('rumi LIKE ?', "%#{@key}%")
        render json: {result: @search.to_json}

        # @search = ImportData.where(:rumi => @key)
        # debugger  
    end
end
