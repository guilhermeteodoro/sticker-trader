import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['content', 'icon']
  static values = {
    open: {
      type: Boolean,
      default: false,
    },
  }

  connect() {
    this.openValue ? this.#show() : this.#hide()
  }

  toggle() {
    this.openValue = !this.openValue
  }

  open() {
    this.openValue = true
  }

  close() {
    this.openValue = false
  }

  openValueChanged(isOpen, wasOpen) {
    if (wasOpen === undefined) return
    isOpen ? this.#show() : this.#hide()
  }

  #show() {
    if (this.hasContentTarget) {
      this.contentTarget.classList.remove('hidden')
    }
    if (this.hasIconTarget) {
      this.iconTarget.style.transform = 'rotate(0deg)'
    }
  }

  #hide() {
    if (this.hasContentTarget) {
      this.contentTarget.classList.add('hidden')
    }
    if (this.hasIconTarget) {
      this.iconTarget.style.transform = 'rotate(-90deg)'
    }
  }
}
