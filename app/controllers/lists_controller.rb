class ListsController < ApplicationController
  def new
    @List = List.new
  end

  def create
    list = List.new(list_params)

    list.save

    redirect_to'/top'
  end

  def index
  end

  def show
  end

  def edit
  end

  private

  def list_params
    params.require(:list).permit(:title,:body)
  end
end
