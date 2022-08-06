class Hello < Grape::API
  resource :hello do
    desc "Get list"
    get do
      authenticate_user_from_token!
      {
       result: true,
       message: 'Hello, world'
      }
    end
  end
end
