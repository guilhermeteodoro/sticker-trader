# frozen_string_literal: true

class Components::Base < Phlex::HTML
  include Components
  include RubyUI

  include Phlex::Rails::Helpers::Routes
  include Phlex::Rails::Helpers::CSPMetaTag
  include Phlex::Rails::Helpers::CSRFMetaTags
  include Phlex::Rails::Helpers::StylesheetLinkTag
  include Phlex::Rails::Helpers::JavaScriptIncludeTag
  include Phlex::Rails::Helpers::Flash
  include Phlex::Rails::Helpers::FormAuthenticityToken
  include Phlex::Rails::Helpers::ImagePath

  register_value_helper :current_user

  def t(key, **opts)
    I18n.t(key, **opts)
  end

  if Rails.env.development?
    def before_template
      comment { "Before #{self.class.name}" }
      super
    end
  end
end
