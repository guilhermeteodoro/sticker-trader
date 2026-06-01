# frozen_string_literal: true

class Views::Collections::Edit < Views::LoggedIn
  def render_title
    div(class: "grid") do
      div(class: "grid-row pt-1") do
        Breadcrumb do
          BreadcrumbList do
            BreadcrumbItem do
              BreadcrumbLink(href: user_path(@current_user)) { t("collections.edit.breadcrumb") }
            end
          end
        end
      end

      div(class: "grid-row") do
        Heading(level: 2) { t("collections.edit.title") }
      end
    end
  end

  def render_content
    div(class: "max-w-md space-y-6") do
      Card(class: "bg-white") do
        CardHeader do
          t("collections.edit.form_title")
        end

        CardContent do
          form(action: user_collection_path(@current_user), method: "post", data: { controller: "import-form" }) do
            input(type: "hidden", name: "_method", value: "patch")
            input(type: "hidden", name: "authenticity_token", value: form_authenticity_token)

            render_import_fields

            div(class: "mt-6") do
              Button(type: :submit) { t("collections.edit.submit") }
            end
          end

          p(class: "mt-4 text-sm text-muted-foreground") { t("collections.edit.warning") }
        end
      end
    end
  end

  private

  def render_import_fields
    FormField do
      FormFieldLabel { t("collections.edit.import_method_label") }
      Combobox do
        ComboboxTrigger(placeholder: t("collections.edit.import_dump"))

        ComboboxPopover do
          ComboboxList do
            ComboboxItem do
              ComboboxRadio(name: "import_method", value: "dump", checked: true, data: { action: "change->import-form#toggle" })
              span { t("collections.edit.import_dump") }
            end
            ComboboxItem do
              ComboboxRadio(name: "import_method", value: "manual", data: { action: "change->import-form#toggle" })
              span { t("collections.edit.import_manual") }
            end
          end
        end
      end
    end

    div(data: { import_form_target: "dump" }) do
      FormField do
        FormFieldLabel { t("collections.edit.dump_label") }
        Textarea(name: "dump", rows: 4, placeholder: t("collections.edit.dump_placeholder"), class: "font-mono text-sm")
      end
    end

    div(class: "hidden", data: { import_form_target: "manual" }) do
      FormField do
        FormFieldLabel { t("collections.edit.missing_label") }
        Textarea(name: "missing_text", rows: 6, placeholder: t("collections.edit.missing_placeholder"), class: "font-mono text-sm")
      end
      FormField do
        FormFieldLabel { t("collections.edit.duplicates_label") }
        Textarea(name: "duplicates_text", rows: 6, placeholder: t("collections.edit.duplicates_placeholder"), class: "font-mono text-sm")
      end
    end
  end
end
