class Base < Grape::API
  def self.auth_headers
    {
      "X-Api-Token" => {
        description: "App Token",
        required: true
      },
      "X-Api-Email" => {
        description: "Customer Email",
        required: true
      }
    }
  end
  format :json
  prefix 'api'
  rescue_from Grape::Exceptions::ValidationErrors do |e|
    error!({result: false, msg: e.message}, 200)
  end
  helpers ApiHelpers
  mount Sessions
  mount Hello

end