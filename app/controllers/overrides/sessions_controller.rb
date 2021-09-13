module Overrides
  class SessionsController < DeviseTokenAuth::SessionsController
    def provider
      super
      'cpf'
    end
  end
end
