class Api::UrlsController < ApplicationController
  def create
    url = Url.create(url: params[:url])

    if url.save
      render json: url, status: 200
    else
      render json: {
        error: "URL creation unsuccessful. Pro tip: URLs cannot be blank.",
        status: 400
      }, status: 400
    end

  end

  def show
    @url = Url.find_by(shortened_url: params[:url].strip.gsub('0', 'O'))

    if @url
      render json: @url, status: 200
    else
      render json: {
        error: "URL not found.  Check spelling and try again.",
        status: 400
      }, status: 400
    end
  end
end
