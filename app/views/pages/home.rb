# frozen_string_literal: true

class Views::Pages::Home < Views::VerticallyCentralized
  def render_content
    div(class: "text-center") do
      img(src: image_path("album.png"), alt: "Sticker Album 2026", class: "mx-auto mb-8 w-1/5 max-w-xs")

      h1(class: "text-4xl font-bold text-foreground mb-4") { t(".title") }
      p(class: "text-lg text-muted-foreground mb-8") { t(".subtitle") }

      div(class: "flex items-center justify-center mb-6") do
        div(class: "grid gap-2") do
          div(class: "grid sm:grid-flow-col grid-flow-row gap-2") do
            Link(variant: :primary, href: new_registration_path) { t(".cta") }
            Link(variant: :outline, href: new_session_path) { t(".login") }
          end

          div(class: "grid gap-2") do
            Link(variant: :ghost, href: diff_path) { t(".diff") }
            render UI::Components::LocaleSwitcher.new
          end
        end
      end
    end
  end
end
