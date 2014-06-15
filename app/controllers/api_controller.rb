require 'tjplurk/robot'
class ApiController < ApplicationController
  def robot
    render json: Robot.instance.respond(params[:q])
  end
end
