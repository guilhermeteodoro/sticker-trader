# frozen_string_literal: true

class Components::Nav < Components::Base
  def view_template
    nav(class: "bg-white shadow-sm border-b") do
      div(class: "max-w-4xl mx-auto px-4 py-3 flex items-center justify-between") do
        a(href: "/", class: "text-xl font-bold text-green-700") { "⚽ Figurinhas 2026" }
      end
    end
  end
end
