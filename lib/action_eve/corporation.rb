module ActionEve
  
  class Corporation < Base
    def initialize(options, api, character)
      super(options, api)
      options[:character] = character
      @character = character
    end
    
    def info
      Corporation.new(@api.corporation_info(self.id, self.character.id), @api, @character)
    end
    
    def members
      members = []
      @api.member_tracking(self.character.id).each do |member|
        members << Member.new(member, @api)
      end
      members
    end
    
    def starbase_details
      
    end
    
  end
  
end