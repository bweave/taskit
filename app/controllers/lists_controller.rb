class ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_list, only: [:edit, :update, :destroy]

  def create
    @list = List.new(list_params)

    respond_to do |format|
      if @list.save
        format.js {}
        ListRelayJob.perform_later(@list)
      else
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @list.update(list_params)
        format.js {}
        ListRelayJob.perform_later(@list)
      else
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  def sort
    params[:order].each do |key,value|
      List.find(value[:id]).update_attribute(:position, value[:position])
    end
    render :nothing => true
  end

  def destroy
    @list.destroy
    respond_to do |format|
      format.js {}
    end
  end

  private
    def set_list
      @list = List.find(params[:id])
    end

    def list_params
      params.require(:list).permit(:project_id, :name)
    end
end
