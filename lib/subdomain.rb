class Subdomain
  def self.matches?(request)
    subdomain = request.subdomain.present? ? request.subdomain : "www"
  end
end
