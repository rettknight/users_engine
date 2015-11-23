module Users
  class ApplicationController < ActionController::Base
    include SessionsHelper
    layout 'layouts/application'
  end
end
