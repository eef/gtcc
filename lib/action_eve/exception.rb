module ActionEve
  module Exceptions
    class BaseException < Exception
    end
    class OptionsException < BaseException
    end
    class InputException < BaseException
    end
    class CredentialsException < BaseException
    end
    class APIException < BaseException
    end
    class MethodException < BaseException
    end
  end
end