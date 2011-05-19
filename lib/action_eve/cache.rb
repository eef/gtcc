module ActionEve
    # TODO: Clean the whole caching process up, it's a piece of shit
    class Cache
      
      include Common
      
      def initialize
        db = Mongo::Connection.new.db("rcorp")
        @cache = db.collection('cache')
      end
      
      def doc(params, path)
        ret = {}
        encoded_params = Digest::SHA1.hexdigest(params.collect {|k,v| v }.join)
        @cur = @cache.find({"params" => encoded_params, "path" => path})
        if @cur.has_next?
          record = @cur.first
          cached_until = record["cached_until"]
          if DateTime.parse(cached_until) > DateTime.now
            raw_xml = record["xml"]
            xml = Nokogiri::XML(raw_xml)
            error = xml.css("error")
          else
            res = request(path, params)
            raw_xml = res
            xml = Nokogiri::XML(raw_xml)
            error = xml.css("error")
            if error.length.eql?(0)
              update(encoded_params, path, raw_xml, xml.css("cachedUntil").text)
            end
          end
        else
          res = request(path, params)
          raw_xml = res
          xml = Nokogiri::XML(raw_xml)
          error = xml.css("error")
          if error.length.eql?(0)
            create(encoded_params, path, raw_xml, xml.css("cachedUntil").text)
          end
        end
        ret[:xml] = xml
        ret[:error] = error
        ret
      end
      
      def request(path, params)
        res = Net::HTTP.post_form(URI.parse("#{API_HOST}#{path}"), params)
        if res.code.eql?("200")
          res.body
        else
          "<?xml version='1.0' encoding='UTF-8'?><eveapi version=\"2\"><error code=\"500\">Unable to contact Eve API</error></eveapi>"
        end
      end
      
      def create(params, path, xml, cached_until)
        @cache.insert({"params" => params, "path" => path, "xml" => xml, "cached_until" => cached_until})
      end
      
      def update(params, path, xml, cached_until)
        @cache.update({"params" => params, "path" => path}, {"params" => params, "path" => path, "xml" => xml, "cached_until" => cached_until})
      end
      
    end
  
end