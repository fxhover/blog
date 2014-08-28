#encoding: utf-8
class BlogsController < ApplicationController

  def index

  end

  def upload_img
    @result = {status: false, message: '', text_id: params[:upload][:text_id] || ''}
    begin
      if params[:upload].present? && params[:upload][:img].present? && remotipart_submitted?
        upload_path = File.join Rails.root, 'public/images'
        upload = SimpleFileupload.new upload_path:upload_path, max_size: 1024*1024*2, type: 'image'
        upload_info = upload.upload params[:upload][:img]
        @result[:status] = true
        @result[:message] = "![#{upload_info[:file_name]}](/images/#{upload_info[:real_file_name]})"
      end
    rescue UploadException => e
      @result[:message] = e.message
    end
    respond_to do |format|
      format.js
    end
  end
end