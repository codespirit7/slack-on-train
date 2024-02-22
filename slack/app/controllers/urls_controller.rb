class UrlsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @url = Url.new(originalUrl: params[:url])
    @url.shortId = generate_short_id

    respond_to do |format|
      if @url.save
        short_url = "http://localhost:3000/short/#{@url.shortId}"
        format.json { render json: { shortId: short_url, originalUrl: @url.originalUrl }, status: :created }
      else
        format.json { render json: @url.errors, status: :unprocessable_entity }
      end
    end
  end

  def redirect_short_url
    short_id = params[:short_id]
    url = Url.find_by(shortId: short_id)
    if url
      redirect_to url.originalUrl, allow_other_host: true
    else
      render plain: "Shortened URL not found", status: :not_found
    end
  end

  private

  def generate_short_id
    charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    key_length = 5
  
    short_id = Array.new(key_length) { charset[rand(charset.length)] }.join
  
    return short_id unless Url.exists?(shortId: short_id)
  end
  

  def url_params
    params.require(:url).permit(:shortId, :originalUrl)
  end
end
