if Rails.env == 'development'
  Bullet.enable = true
  Bullet.rails_logger = true
end
