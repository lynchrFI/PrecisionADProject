class ClientsController < ApplicationController
    get '/clients' do
        if logged_in?
            @clients = Client.all
            erb :"clients/index"
        else
            redirect '/login'
        end
    end
    
    get '/clients/new' do
        if logged_in?
            erb :'clients/create'
        else 
            redirect '/login'
        end
    end

    post '/clients' do
        if logged_in?
            if params[:info] == ""
                redirect to "/clients/new"
            else
                @client = current_user.clients.build(
                  name: params[:name], 
                  number: params[:number], 
                  client_info: params[:client_info],
                  vehicle: params[:vehicle]
                  )
                if @client.save
                    redirect to "/clients/#{@client.id}"
                else
                    redirect to "/clients/new"
                end
            end
        else
            redirect to '/login'
        end
    end

    get '/clients/:id' do
        if logged_in?
          binding.pry
          @client = Client.find_by_id(params[:id])
          erb :'clients/show'
        else
          redirect to '/login'
        end
      end
    
      get '/clients/:id/edit' do
        if logged_in?
          @client = Client.find_by_id(params[:id])
          if @client && @client.user == current_user
            erb :'clients/edit'
          else
            redirect to '/clients'
          end
        else
          redirect to '/login'
        end
      end
    
      patch '/clients/:id' do
        if logged_in?
          if params[:info] == ""
            redirect to "/clients/#{params[:id]}/edit"
          else
            @client = Client.find_by_id(params[:id])
            if @client && @client.user == current_user
              if @client.update(info: params[:info])
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
    
      delete '/clients/:id/delete' do
        if logged_in?
          @client = Client.find_by_id(params[:id])
          if @client && @client.user == current_user
            @client.delete
          end
          redirect to '/clients'
        else
          redirect to '/login'
        end
      end
    end



