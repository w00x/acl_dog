# -*- coding: utf-8 -*-
class UsersController < ApplicationController
  skip_before_filter :authenticate, :only => [:new, :create]
  skip_before_filter :permission, :only => [:new, :create]
  
  def new
    @user = User.new

    render :layout => false
  end
  
  def create
    begin
      if params[:user][:password] == params[:user][:password_confirmation]
        User.transaction do
          @user = User.new(params[:user].permit(:email, :password))
          @user.active = true
          @user.role_id = Role.find_by(nombre: "user").id

          @user.save

          flash[:success] = true
          flash[:notice] = 'Usuario satisfactoriamente creado.'
          redirect_to login_path
        end
      else
        flash[:success] = true
        flash[:notice] = 'Contraseñas deben ser iguales'
        redirect_to new_user_path
      end
    rescue Exception => e
      flash[:success] = false
      flash[:notice] = 'Problemas al crear el usuario'
      
      ActiveRecord::Rollback
      redirect_to new_user_path
    end
  end
  
  def edit
    @user = User.find(session[:user_id])
  end
  
  def update
    @user = User.find(session[:user_id])

    if params[:user][:password] == params[:user][:password_confirmation] and @user.update_attributes(params[:user].permit(:email, :password))
      redirect_to edit_user_path, :notice => 'Usuario actualizado satisfactoriamente.'
    else
      flash[:success] = false
      if params[:user][:password] != params[:user][:password_confirmation]
        flash[:notice] = 'Contraseña incorrecta'
      else
        flash[:notice] = 'Problemas al modificar la cuenta'
      end
      render :action => 'edit'
    end
  end
end