class UrlsController < ApplicationController
  def create
    url = Url.create(url_params)

    if url.save
      respond_to do |format|
        format.html
        format.js
        binding.pry
      end
    else
      flash[:error] = "URL creation unsuccessful. Pro tip: URLs cannot be blank."
      render nothing: true
    end

  end

  def index
    @new_url = Url.new
  end

  def show
    @url = Url.find_by(shortened_url: url_params[:url].strip.gsub('0', 'O'))

    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def url_params
    params.require(:url).permit(:url)
  end
end
