class ApplicationController < ActionController::Base
  helper Openseadragon::OpenseadragonHelper
  # Adds a few additional behaviors into the application controller
  include Blacklight::Controller
  include Hydra::Controller::ControllerBehavior

  # Adds CurationConcerns behaviors to the application controller.
  include CurationConcerns::ApplicationControllerBehavior
  include CurationConcerns::ThemedLayoutController
  with_themed_layout '1_column'


  # Adds a few additional behaviors into the application controller 
  include Blacklight::Controller  
  # Adds Sufia behaviors into the application controller 
  include Sufia::Controller

  # Please be sure to impelement current_user and user_session. Blacklight depends on 
  # these methods in order to perform user specific actions. 

  with_themed_layout '1_column'

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
