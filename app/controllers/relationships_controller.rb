class RelationshipsController < ApplicationController
    before_action :set_user, only: [:create]
  
    def create
      @user = User.find(params[:followed_id])
      @relationship = current_user.active_relationships.create(followed_id: @user.id)

      current_user.reload
      @user.reload

      respond_to do |format|
        format.js
      end
    end
      
    def destroy
      @relationship = current_user.active_relationships.find_by(id: params[:id])
      if @relationship
        @user = User.find_by(id: @relationship.followed_id)
        @relationship.destroy
        current_user.reload
        @user.reload if @user
      else
        head :not_found  
        return
      end

      respond_to do |format|
        format.js
      end
    end 
  
    private
  
    def set_user
      @user = User.find(params[:followed_id])
    end
  end