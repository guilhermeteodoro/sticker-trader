import CollapsibleController from "./ruby_ui/collapsible_controller"

// Extends the RubyUI collapsible to persist open/closed state in sessionStorage.
// Use data-controller="persistent-collapsible" instead of "ruby-ui--collapsible".
// Add data-persistent-collapsible-key-value="unique-key" to identify.

export default class extends CollapsibleController {
  static values = {
    ...CollapsibleController.values,
    key: { type: String, default: "" }
  }

  connect() {
    if (this.keyValue) {
      const stored = sessionStorage.getItem(this.#storageKey)
      if (stored !== null) {
        this.openValue = stored === "true"
      }
    }
    super.connect()
  }

  openValueChanged(isOpen, wasOpen) {
    super.openValueChanged(isOpen, wasOpen)
    if (this.keyValue && wasOpen !== undefined) {
      sessionStorage.setItem(this.#storageKey, isOpen)
    }
  }

  get #storageKey() {
    return `ui-state:${this.keyValue}`
  }
}
