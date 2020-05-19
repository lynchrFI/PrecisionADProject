class ProductsController < ApplicationController
    get '/products' do
        if logged_in?
            @products = current_user.products
            erb :"products/index"
        else
            redirect '/login'
        end
    end
    get '/products/new' do
        if logged_in?
            erb :'products/create'
        else 
            redirect '/login'
        end
    end
  
end