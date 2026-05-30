import { application } from "./application"

import ClipboardController from "./clipboard_controller"
import ImportFormController from "./import_form_controller"

// RubyUI controllers
import DropdownMenuController from "./ruby_ui/dropdown_menu_controller"
import FormFieldController from "./ruby_ui/form_field_controller"

application.register("clipboard", ClipboardController)
application.register("import-form", ImportFormController)
application.register("ruby-ui--dropdown-menu", DropdownMenuController)
application.register("ruby-ui--form-field", FormFieldController)
