# See https://github.com/oesmith/puffing-billy/issues/139
module Billy
  # puffing-billy/lib/billy/config.rb
  class Config
    attr_accessor :after_cache_handles_request
  end

  # puffing-billy/lib/billy/handlers/cache_handler.rb
  class CacheHandler
    def handle_request(method, url, headers, body)
      method = method.downcase
      if handles_request?(method, url, headers, body)
        if (response = cache.fetch(method, url, body))
          Billy.log(:info, "puffing-billy: CACHE #{method} for '#{url}'")

          if Billy.config.dynamic_jsonp
            replace_response_callback(response, url)
          end
          
          if Billy.config.after_cache_handles_request
            request = { method: method, url: url, headers: headers, body: body }
            Billy.config.after_cache_handles_request.call(request, response)
          end
          
          return response
        end
      end
      nil
    end
  end  
end
