# frozen_string_literal: true

class Views::Sessions::New < Views::Base
  def view_template
    h1(class: "text-2xl font-bold text-gray-900 mb-6") { t("sessions.new.title") }

    form(action: session_path, method: "post") do
      input(type: "hidden", name: "authenticity_token", value: form_authenticity_token)

      FormField do
        FormFieldLabel { t("sessions.new.email_label") }
        Input(type: "email", name: "email", required: true, autofocus: true, placeholder: t("sessions.new.email_placeholder"))
      end

      div(class: "mt-6") do
        Button(type: :submit) { t("sessions.new.submit") }
      end
    end

    p(class: "mt-4 text-sm text-muted-foreground") do
      plain "#{t("sessions.new.no_account")} "
      a(href: new_registration_path, class: "text-primary hover:underline") { t("sessions.new.register_link") }
    end
  end
end
