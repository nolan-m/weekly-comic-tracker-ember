class ComicsController < ApplicationController
  def index
    if Comic.last.week_number == Date.today.cweek
      @comics = Comic.all.where(:week_number => Date.today.cweek)
    else
      @comics = Comic.this_week(Comic.create_url)
    end
    render :json => @comics
  end

  def create
    @comic = Comic.new(comic_params)
    if @comic.save
      render :json => @comic, :status => 201
    else
      render :json => @comic.errors, :status => 422
    end
  end

  def show
    @comic = Comic.find(params[:id])
    render :json => @comic
  end

  def update
    @comic = Comic.find(params[:id])
    if @comic.update(comic_params)
      head :no_content
    else
      render :json => @comic.errors, :status => 422
    end
  end

  def destroy
    @comic = Comic.find(params[:id])
    @comic.destroy
    head :no_content
  end

private

  def comic_params
    params.fetch(:comic).permit(:marvel_id, :week_number, :title, :issue_number, :description, :image)
  end
end
