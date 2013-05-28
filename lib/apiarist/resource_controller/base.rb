module Apiarist
  module ResourceController
    class Base < Apiarist::Controller::Base
      InheritedResources::Base.inherit_resources(self)

      respond_to :json
      self.responder = Responder
    end
  end
end
