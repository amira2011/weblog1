class WlogsController < ApplicationController
  def index
  end

  def home
  end

  def import1
   Wlog.import1(params[:file])
   redirect_to wlogs_path, notice: "Logs Added successfully"
 end





end
