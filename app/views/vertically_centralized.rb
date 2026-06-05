# frozen_string_literal: true

class Views::VerticallyCentralized < Views::Base
  def view_template
    div(class: "flex min-h-screen items-center") do
      div(class: "max-w-lg grow-1 mx-auto p-2") do
        render_content
      end
    end
  end

  private

    def render_content = nil
end
