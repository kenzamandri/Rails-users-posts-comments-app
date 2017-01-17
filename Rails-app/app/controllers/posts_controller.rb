class PostsController < ApplicationController

      def index
        @posts = Post.all
      end

      def new
      end

      def create
        @new_post = Post.create(
          title: params[:post][:title],
          content: params[:post][:content],
          user_id: params[:post][:user_id]
        )

        if @new_post
          redirect_to url_for(:controller => :posts, :action => :index)
        else
          redirect_to url_for(:controller => :posts, :action => :new)
        end
      end

      def show
        @post = Post.find(params[:id])
        @post_user = @post.user.fname
        @comments = @post.comments


        if session[:post_id] # if logged in
          @message = "You're now logged in! Welcome to your profile page."
        else
          @message = "You're not logged in yet, please login first!"
        end


      end

      def edit
        @post = Post.find(params[:id])
      end

      def update
        @post = Post.find(params[:id])
        @post.update({
          title: params[:post][:title],
          content: params[:post][:content],
          user_id: params[:post][:user_id]
        })

        if (@post)
          redirect_to url_for(:controller => :posts, :action => :index)
        else
          redirect_to url_for(:controller => :posts, :action => :edit)
        end
      end

      def destroy
        Post.delete(params[:id])
        redirect_to url_for(:controller => :posts, :action => :index)
      end


end
