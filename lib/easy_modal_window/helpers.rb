require 'easy_modal_window/helpers/dialog_helpers.rb'

module EasyModalWindow::DialogHelpers; end

ActionView::Base.send :include, EasyModalWindow::DialogHelpers
ActionController::Base.prepend_view_path File.dirname(__FILE__) + '/../app/views'