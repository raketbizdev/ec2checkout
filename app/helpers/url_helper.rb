module UrlHelper
  def with_subdomain(subdomain)
    parsed_url = URI.parse(request.url)
    parsed_url.host = "#{subdomain}.#{parsed_url.host}"
    
    # Ensure subdomain is a string before checking if it's empty
    subdomain = subdomain.to_s unless subdomain.is_a?(String)
    subdomain += "." unless subdomain.empty?
    
    parsed_url.to_s
  end
  
  def url_for(options = nil)
    if options.kind_of?(Hash) && options.has_key?(:subdomain)
      options[:host] = with_subdomain(options.delete(:subdomain))
    end
    super
  end
end
