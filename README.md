# EasyModalWindow

This is wrapper for jQuery-UI Dialog. Additionaly it contain several templates for render errors from ActiveRecord and ErrorMessagesContainer.

## Installation

Add this line to your application's Gemfile:

    gem 'easy_modal_window'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install easy_modal_window

## Usage

Gem provide several helpers for easy render jQuery-UI dialog and list with ActiveRecord errors.

### jQuery-UI dialog

Helper `render_base_dialog`. It take parameters like a `dialog`, but in more easy way and with less required parameters.

    render_base_dialog(
      render_template:  'example_template',
      locals:           {id: 42},
      resizable:        false,
      height:           'auto',
      width:            'auto',
      before_close: {
        condition:      true,
        action:         'return true;'
      },
      buttons: {
        load_button: {
          name:         l(:load_button),
          action:       "$('#modal-window-ajax-form').submit();"
        },
        close_button: {
          name:         l(:close_button),
          action:       "$(this).dialog('close');"
        }
      }

Here we can skip any parameters except `render_template` or `render_partial`.

**NOTE:** by default modal window puts in `#ajax-modal` element; you can specify other selector in `window_selector` option.

### ActiveRecord errors

Helper `render_active_record_result` provide easy way to render list with several AR errors.

    render_active_record_result(object: object,
                                success_message: l(:success_message))

If `object.errors.blank?` you see value of `success_message`.

### ErrorsContainer errors

Helper `render_errors_container_result` provide easy way to render nested lists with messages from [ErrorsContainer](https://github.com/Loriowar/error_messages_container).

    render_errors_container_result(object: object,
                                   success_message: l(:success_message),
                                   container_class: 'upper-ul-class',           # class for upper ul element
                                   element_class: 'first-li-class',             # class for li elements which contain group name
                                   errors_group_class: 'div-in-li-class')       # class for div with errors group name

CSS-class parameters are optional.

## Contributing

1. Fork it ( http://github.com/Loriowar/easy_modal_window/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
