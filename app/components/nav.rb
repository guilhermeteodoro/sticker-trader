# frozen_string_literal: true

class Components::Nav < Components::Base
  def initialize(current_user: nil)
    @current_user = current_user
  end

  def view_template
    nav(class: "bg-white shadow-sm border-b") do
      div(class: "max-w-4xl mx-auto px-4 py-3 flex items-center justify-between") do
        a(href: "/", class: "text-xl font-bold text-green-700") { "⚽ Figurinhas 2026" }

        div(class: "flex items-center gap-4 text-sm") do
          if @current_user
            a(href: "/u/#{@current_user.slug}", class: "text-gray-600 hover:text-gray-900") { @current_user.name }
            button(form: "logout-form", type: "submit", class: "text-gray-500 hover:text-gray-700") { "Log out" }
          else
            a(href: "/session/new", class: "text-gray-600 hover:text-gray-900") { "Log in" }
            a(href: "/registration/new", class: "bg-green-600 text-white px-3 py-1 rounded font-medium hover:bg-green-700") { "Register" }
          end
        end
      end
    end

    if @current_user
      form(id: "logout-form", action: "/session", method: "post", class: "hidden") do
        input(type: "hidden", name: "_method", value: "delete")
        input(type: "hidden", name: "authenticity_token", value: helpers.form_authenticity_token)
      end
    end
  end
end
