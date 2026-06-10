# frozen_string_literal: true

module RubyUI
  class Collapsible < Base
    def initialize(open: false, persist_key: nil, **attrs)
      @open = open
      @persist_key = persist_key
      super(**attrs)
    end

    def view_template(&)
      div(**attrs, &)
    end

    private

    def default_attrs
      data = {
        controller: @persist_key ? "ui-state ruby-ui--collapsible" : "ruby-ui--collapsible",
        ruby_ui__collapsible_open_value: @open
      }
      if @persist_key
        data[:ui_state_key_value] = @persist_key
        data[:ui_state_attr_value] = "data-ruby-ui--collapsible-open-value"
      end
      { data: data }
    end
  end
end
