module Entities
  class Base < Grape::Entity
    format_with(:null) { |v| v.is_a?(FalseClass) ? v : v.blank? ? "" : v }
  end
end