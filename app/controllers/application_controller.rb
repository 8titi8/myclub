class ApplicationController < ActionController::Base
    protect_from_forgery_with: :exception
    include SessionsHelper
end
