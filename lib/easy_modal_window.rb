require 'easy_modal_window/version'
require 'easy_modal_window/helpers'

module EasyModalWindow
  class Dialog

    attr_reader :modal_options

    ALLOWED_OPTIONS = [:window_selector, :title_selector, :render_template, :render_partial, :formats,
                       :locals, :resizable, :height, :width, :buttons, :before_close, :success_message,
                       :object, :container_class, :element_class, :errors_group_class].freeze

    def initialize(args)
      @modal_options = {}
      @modal_options[:window_selector] = '#ajax-modal'
      @modal_options[:title_selector] = 'h3.title'
      @modal_options[:render_template] = nil
      @modal_options[:render_partial] = nil
      @modal_options[:locals] = {}
      @modal_options[:formats] = [:html]
      @modal_options[:resizable] = true
      @modal_options[:height] = 'auto'
      @modal_options[:width] = 'auto'
      # hash with button descriptions: {first_button: {name: 'Name',
      #                                                condition: -> {...},
      #                                                action: 'location.reload();',
      #                                                class: 'my-css-class'},
      #                                 second_button: ...}
      @modal_options[:buttons] = {}
      # dialog callbacks
      # {condition: ->{...}, action: '...'}
      @modal_options[:before_close] = {}

      # options for result templates
      @modal_options[:success_message] = 'All right'
      @modal_options[:object] = nil
      @modal_options[:container_class] = ''
      @modal_options[:element_class] = ''
      @modal_options[:errors_group_class] = ''

      @modal_options.merge!(args.slice(*EasyModalWindow::Dialog::ALLOWED_OPTIONS))
    end

    (ALLOWED_OPTIONS - [:before_close, :buttons]).each do |method|
      class_eval <<-EOT, __FILE__, __LINE__ + 1
        def #{method}
          @modal_options[:#{method}]
        end
      EOT
    end

    # TODO: simplify this method
    def before_close
      result = {}
      if @modal_options[:before_close].has_key?(:action) && @modal_options[:before_close][:action].present?
        result[:action] = @modal_options[:before_close][:action]
      else
        result[:condition] = false
        result[:action] = ''
        return result
      end

      result[:condition] = @modal_options[:before_close][:condition].nil? || value_of(@modal_options[:before_close][:condition])

      result
    end

    def buttons
      @modal_options[:buttons].inject([]) do |h, (k, v)|
        h.push(
            {
                internal_name: k,
                name: v[:name] || 'unknown',
                condition: value_of(v[:condition]).nil? || value_of(v[:condition]),
                action: v[:action] || '',
                class: v[:class] || ''
            }
        )
      end
    end

  private

    def value_of(var)
      var.is_a?(Proc) ? var.call : var
    end

  end
end
