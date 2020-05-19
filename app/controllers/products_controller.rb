class ProductsController < ApplicationController
    get '/products' do
        if logged_in?
            @product = current_user.products
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

    post '/products' do
        if logged_in?
            if params[:product_info] == ""
                redirect to "/products/new"
            else
                @product = current_user.clients.build(
                  name: params[:name], 
                  brand: params[:brand], 
                  product_info: params[:product_info],
                  price: params[:price]
                  stock: params[:stock]
                  )
                if @product.save
                    redirect to "/products/#{@product.id}"
                else
                    redirect to "/products/new"
                end
            end
        else
            redirect to '/login'
        end
    end
  
end