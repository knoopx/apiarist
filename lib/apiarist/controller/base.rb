module Apiarist
  module Controller
    class Base < Apiarist::AbstractController
      respond_to :json

      include Apiarist::Controller::Serialization
    end
  end
end