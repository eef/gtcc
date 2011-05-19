module ActionEve
  
  class API < Base
    
    def initialize(*args)
      @store = Store.new
      @store << User.new(parse_args!(args)) if args.length > 0
    end
    
    def store
      @store
    end
    
    def users
      @store.users
    end
    
    def <<(user)
      @store << user
    end
    
  end
  
  class Store
    def initialize(*args)
      @users = {}
      args.each do |user|
        users[user.id] = user
      end
    end
    
    def <<(user)
      @users[user.id] = user
    end
    
    def users
      @users.values
    end
    
    def [](id)
      @users[id]
    end
    
  end
  
end