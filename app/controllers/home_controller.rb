class HomeController < ApplicationController
    def search
        @key = params[:search]
        debugger 
        @search = ImportData.where('rumi LIKE ?', "%#{@key}%")

        # @search = ImportData.where(:rumi => @key)
        # debugger  
    end
end
