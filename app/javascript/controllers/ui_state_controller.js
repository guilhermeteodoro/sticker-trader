import { Controller } from "@hotwired/stimulus"

// General-purpose UI state persistence via sessionStorage.
// Persists a single DOM attribute's value across page loads and Turbo frame replacements.
//
// IMPORTANT: list "ui-state" BEFORE the target controller in data-controller so it
// sets the attribute before the target controller connects and reads it.
//
// Usage:
//   data-controller="ui-state ruby-ui--collapsible"
//   data-ui-state-key-value="unique-key"
//   data-ui-state-attr-value="data-ruby-ui--collapsible-open-value"

export default class extends Controller {
  static values = {
    key: String,
    attr: String
  }

  connect() {
    const stored = sessionStorage.getItem(this.#storageKey)
    if (stored !== null) {
      this.element.setAttribute(this.attrValue, stored)
    }

    this.observer = new MutationObserver(() => this.#persist())
    this.observer.observe(this.element, { attributes: true, attributeFilter: [this.attrValue] })
  }

  disconnect() {
    if (this.observer) this.observer.disconnect()
  }

  #persist() {
    const value = this.element.getAttribute(this.attrValue)
    if (value !== null) {
      sessionStorage.setItem(this.#storageKey, value)
    }
  }

  get #storageKey() {
    return `ui-state:${this.keyValue}`
  }
}
