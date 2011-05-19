module ActionEve
  module Common
    
    API_HOST = "http://api.eve-online.com/"
    
    def parse_args!(args)
      args.last.is_a?(Hash) ? args.pop : {}
    end
  end
end