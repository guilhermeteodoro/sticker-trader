import { Controller } from "@hotwired/stimulus"

// Wraps ruby-ui--collapsible and persists open/closed state in sessionStorage.
// Use data-persistent-collapsible-key-value="unique-key" to identify.

export default class extends Controller {
  static values = { key: String }

  connect() {
    const stored = sessionStorage.getItem(this.#storageKey)
    if (stored !== null) {
      const collapsible = this.#collapsibleController
      if (collapsible) {
        stored === "true" ? collapsible.open() : collapsible.close()
      }
    }

    this.observer = new MutationObserver(() => this.#persist())
    this.observer.observe(this.element, { attributes: true, subtree: true, attributeFilter: ["data-ruby-ui--collapsible-open-value"] })
  }

  disconnect() {
    if (this.observer) this.observer.disconnect()
  }

  #persist() {
    const collapsible = this.#collapsibleController
    if (collapsible) {
      sessionStorage.setItem(this.#storageKey, collapsible.openValue)
    }
  }

  get #storageKey() {
    return `collapsible:${this.keyValue}`
  }

  get #collapsibleController() {
    return this.application.getControllerForElementAndIdentifier(this.element, "ruby-ui--collapsible")
  }
}
