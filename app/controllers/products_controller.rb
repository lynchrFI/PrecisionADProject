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
                  price: params[:price],
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

    get '/products/:id' do
        if logged_in?
          @product = Product.find_by_id(params[:id])
          if @product.user == current_user
            erb :'products/show'
          else
            redirect to '/products'
          end
        else
          redirect to '/login'
        end
      end

      get '/products/:id/edit' do
        if logged_in?
          @product = Product.find_by_id(params[:id])
          if @product && @product.user == current_user
            erb :'product/edit'
          else
            redirect to '/products'
          end
        else
          redirect to '/login'
        end
      end

      patch '/clients/:id' do
        if logged_in?
          if params[:client_info] == ""
            redirect to "/clients/#{params[:id]}/edit"
          else
            @client = Client.find_by_id(params[:id])
            if @client && @client.user == current_user
              if @client.update(client_info: params[:client_info])
                redirect to "/clients/#{@client.id}"
              else
                redirect to "/clients/#{@client.id}/edit"
              end
            else
              redirect to '/clients'
            end
          end
        else
          redirect to '/login'
        end
      end

  
end