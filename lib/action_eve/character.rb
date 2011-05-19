module ActionEve
  
  class Character < Base

    def corporation
      Corporation.new({:id => corporation_id, :name => corporation_name}, @api, self)
    end
  
    def info
      character_info = @api.character_info(self.id)
      @options.merge!(character_info)
    end
    
    def skills
      skills = []
      character_skills = @api.character_skills(self.id)
      character_skills.each do |skill|
        skills << Skill.new(skill, @api)
      end
      skills
    end
    
    def is_director?
      role = @api.is_director(self.id)
      role
    end
  
  end
  
end