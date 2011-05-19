module ActionEve
  
  class User < Base
    
    def initialize(*args)
      super(parse_args!(args))
      raise(Exceptions::InputException, "ID is missing") unless @options[:id]
      raise(Exceptions::InputException, "API Key is missing") unless @options[:api_key]
    end
    
    def characters
      characters = []
      @api.characters.each do |character_id, character|
        characters << Character.new(character, @api)
      end
      characters
    end
    
  end
  
end