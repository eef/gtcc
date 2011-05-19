module ActionEve
  
  class Base
    
    include Common
    
    def initialize(options, api=nil)
      @api ||= api
      @api ||= Comms::API.new(options)
      @options = options
    end
    
    def method_missing(method, *args)
      if @options.has_key?(method.to_sym)
        return(@options[method.to_sym])
      end
      raise(Exceptions::MethodException,"That method is missing, check under the cushion")
    end
    
  end
  
end