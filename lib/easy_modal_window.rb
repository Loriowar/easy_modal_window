require 'easy_modal_window/version'
require 'easy_modal_window/helpers'

module EasyModalWindow
  class Dialog

    attr_reader :modal_options

    def initialize(args)
      @modal_options = {}
      @modal_options[:window_selector] = '#ajax-modal'
      @modal_options[:title_selector] = 'h3.title'
      @modal_options[:render_template] = ''
      @modal_options[:formats] = [:html]
      @modal_options[:resizable] = true
      @modal_options[:height] = 'auto'
      @modal_options[:width] = 'auto'
      # hash with button descriptions: {first_button: {name: 'Name',
      #                                                condition: -> {...},
      #                                                action: 'location.reload();'},
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

      @modal_options.merge!(args.select{|k, _| @modal_options.keys.include?(k.to_sym)})
    end

    @modal_options.keys.reject{|key| [:before_close, :buttons].include?(key) }.each do |method|
      class_eval <<-EOT, __FILE__, __LINE__ + 1
        def #{method}
          @modal_options[:#{method}]
        end
      EOT
    end

    def before_close
      result = {}
      if @modal_options[:before_close].has_key?(:action) && @modal_options[:before_close][:action].present?
        result[:action] = @modal_options[:before_close][:action]
      else
        result[:condition] = false
        result[:action] = ''
        return result
      end

      if @modal_options[:before_close].has_key?(:condition) && @modal_options[:before_close][:condition].present?
        result[:condition] = value_of(@modal_options[:before_close][:condition])
      else
        result[:condition] = true
      end

      result
    end

    def buttons
      @modal_options[:buttons].inject([]) do |h, v|
        option = {}
        option[:name] = v.last[:name] || 'unknown'
        option[:condition] = value_of(v.last[:condition])
        option[:action] = v.last[:action] || ''
        h << option
        h
      end
    end

  private

    def value_of(var)
      var.lambda? ? var.call : var
    end

  end
end
