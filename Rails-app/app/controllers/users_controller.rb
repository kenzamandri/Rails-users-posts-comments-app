class UsersController < ApplicationController


    def index
      @users = User.all
    end

    def new
      @message = "Sign up to our new awesome app!"
    end

    def create
      @new_user = User.create(
        fname: params[:user][:fname],
        lname: params[:user][:lname],
        username: params[:user][:username],
        email: params[:user][:email],
        password: params[:user][:password]
      )

      if @new_user
        session[:user_id] = @new_user.id
        redirect_to url_for(:controller => :users, :action => :index)
      else
        redirect_to url_for(:controller => :users, :action => :new)
      end

    end

    def show
      @user = User.find(params[:id])

      @user_posts = @user.posts

      @comments = Comment.all

      if session[:user_id] # if logged in
        @message = "Welcome! You successfully logged in!"
      else
        @message = "Try logging in first!"
      end

    end

    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      @user.update({
        fname: params[:user][:fname],
        lname: params[:user][:lname],
        password: params[:user][:password],
        username: params[:user][:username],
        email: params[:user][:email]
      })

        if (@user)
          redirect_to url_for(:controller => :users, :action => :index)
        else
          redirect_to url_for(:controller => :users, :action => :edit)
        end
    end

    def destroy
      User.delete(params[:id])
      session.destroy
      redirect_to url_for(:controller => :users, :action => :index)
    end

    def login_form
      if session[:user_id] # if logged in
        @message = "You're already logged in."
      else
        @message = "Login below!"
      end
    end

    def create_login
      @user = User.where(username: params[:username], password: params[:password]).first

      if @user
        session[:user_id] = @user.id
        # redirect_to url_for(:controller => :users, :action => :index)
        redirect_to user_path(session[:user_id])
      else
        redirect_to url_for(:controller => :users, :action => :login)
      end
    end

    def logout
      session.destroy
      redirect_to url_for(:controller => :users, :action => :index)
    end

end
