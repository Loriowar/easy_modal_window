module EasyModalWindow
  module DialogHelpers

    def render_base_dialog(options)
      render_modal_window(options.merge(view: 'base_dialog', format: :js))
    end

    def render_active_record_result(options)
      render_modal_window(options.merge(view: 'active_record_result', format: :html))
    end

    def render_errors_container_result(options)
      render_modal_window(options.merge(view: 'errors_container_result', format: :html))
    end

  private

    def render_modal_window(options)
      if options.has_key?(:view)
        dialog = EasyModalWindow::Dialog.new(options)
        render template: "easy_modal_window/#{options[:view]}",
               locals: {modal_options: dialog},
               formats: options[:format] || [:js]
      end
    end

  end
end