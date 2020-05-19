class ProductsController < ApplicationController
    get '/clients' do
        if logged_in?
            @products = current_user.products
            erb :"products/index"
        else
            redirect '/login'
        end
    end
    
  
end