class TweetsController < ApplicationController

    get '/tweets' do 
        if !logged_in?
            redirect '/login'
        else 
            @tweets = Tweet.all 
            erb :'/tweets/tweets'        
        end 
    end 

    get '/tweets/new' do 
        if !logged_in?
            redirect '/login'
        else 
            erb :"/tweets/new"
        end 
    end 

    post '/tweets' do 
        if logged_in?
            if params[:content] == ""
                redirect to '/tweets/new'
            else 
                @tweet = current_user.tweets.build(content: params[:content])
                @tweet.save
                if @tweet.save 
                    redirect to "/tweets/#{@tweet.id}"
                else 
                    redirect '/tweets/new'
                end 
            end 
        else 
            redirect '/login'
        end 
    end 

    get '/tweets/:id' do
        if !logged_in?
            redirect '/login'
        else 
            @tweet = Tweet.find(params[:id])            
            erb :'/tweets/show'
        end 
    end
    
    get '/tweets/:id/edit' do
        if !logged_in?
            redirect '/login'
        else
            @tweet = Tweet.find(params[:id])
            erb :'/tweets/edit'
        end 
    end 

    patch '/tweets/:id/edit' do
        if !logged_in?
            redirect '/login'
        else
            @tweet = Tweet.find(params[:id])
            if !params[:content] == ""
                redirect to "/tweets/#{@tweet.id}/edit"
            else 
                @tweet.content = params[:content]
                @tweet.save
            end 
        end 
    end 

    delete '/tweets/:id/delete' do
        if !logged_in?
            redirect '/login'
        else
            @tweet = Tweet.find(params[:id])
            if @tweet.user_id == current_user.user_id
                @tweet.delete
                redirect to '/tweets'
            else 
                erb :'/tweets/error'
            end 
        end 
    end 
end
