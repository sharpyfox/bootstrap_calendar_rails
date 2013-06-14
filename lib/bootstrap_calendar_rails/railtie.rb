# Author::    Nikita Vasiliev  (mailto:sharpyfox@gmail.com)
# Encoding::  utf-8
# License::   Distributes under the same terms as Ruby

require 'bootstrap_calendar_rails/view_helper'

# Tell to the world about ViewHelpers module
module BootstrapCalendarRails
  class Railtie < Rails::Railtie
    initializer "placehold.view_helpers" do |app|
      ActionView::Base.send :include, ViewHelpers
    end
  end
end