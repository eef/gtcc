require 'date'
require 'net/http'
require 'digest/sha1'
require 'uri'

module ActionEve
  
  module Comms
    
    class API

      include Common
      
      def initialize(*args)
        @options = parse_args!(args)
        @comms = Request.new(@options)
      end

      def characters
        result = {}
        doc = @comms.call('account/Characters.xml.aspx')
        doc.css('rowset[name="characters"] > row').each do |row|
          character = {
            :id => row['characterID'].to_i,
            :name => row['name'],
            :corporation_id => row['corporationID'].to_i,
            :corporation_name => row['corporationName']
          }
          result[character[:id]] = character
        end
        result
      end
      
      def character_info(character_id)
        result = {}
        doc = @comms.call('eve/CharacterInfo.xml.aspx', :characterID => character_id)
        rows = doc.css('result').first.children
        rows.each {|row| result[row.name.underscore.to_sym] = row.text}
        result
      end
      
      def is_director(character_id)
        doc = @comms.call("char/CharacterSheet.xml.aspx", :characterID => character_id)
        if doc.css('row[roleName="roleDirector"]').length > 0
          return(true)
        end
        return(false)
      end
      
      def character_skills(character_id)
        character_skills = []
        doc = @comms.call("char/CharacterSheet.xml.aspx", :characterID => character_id)
        rows = doc.css('rowset[name="skills"] > row')
        rows.each do |row|
          skill = {
            :type_id => row["typeID"],
            :skill_points => row["skillpoints"],
            :level => row["level"]
          }
          character_skills << skill
        end
        character_skills
      end
      
      def corporation_info(corporation_id, character_id=nil)
        result = {}
        doc = @comms.call("corp/CorporationSheet.xml.aspx", :characterID => character_id, :corporation_id => corporation_id)
        rows = doc.css('result').first.children
        rows.each {|row| result[row.name.underscore.to_sym] = row.text unless row.name.eql?("logo")}
        result
      end
      
      def member_tracking(character_id)
        result = []
        doc = @comms.call("corp/MemberTracking.xml.aspx", :characterID => character_id)
        rows = doc.css('rowset > row')
        rows.each do |row|
          member = {}
          row.attributes.each do |key, value|
            member[key.underscore.to_sym] = value.value
          end
          result << member
        end
        result
      end
    end
    
    class Request
      
      include Common
    
      def initialize(*args)
        options = parse_args!(args)
        @cache = Cache.new
        @initial_params = {}
        @initial_params[:userID] = options[:id] or raise Exceptions::OptionsException, "User ID is missing"
        @initial_params[:apiKey] = options[:api_key] or raise Exceptions::OptionsException, "API Key is missing"
      end
    
      def call(uri, *args)
        params = parse_args!(args).merge(@initial_params)
        data = @cache.doc(params, uri)
        unless data[:error].length.eql?(0)
          case data[:error].first['code'][0,1]
            when '1'
              raise Exceptions::InputException, data[:error].text
            when '2'
              raise Exceptions::CredentialsException, data[:error].text
            else
              raise Exceptions::APIException, data[:error].text
          end
        end
        data[:xml]
      end

    end

  end
  
end