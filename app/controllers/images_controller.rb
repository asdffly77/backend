class ImagesController < ApplicationController
  before_action :authenticate!
  skip_before_action :verify_authenticity_token

  def create
    image = Image.create(:image => params[:image])
    render json: {
      url: image.image.url
    }
  end
end
