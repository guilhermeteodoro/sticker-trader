import { Controller } from "@hotwired/stimulus"

// Generic split-button controller.
// The dropdown options switch the primary button's action and label.
// Each option element needs: data-split-button-action-value, data-split-button-label-value
// The form needs: data-split-button-target="form"
// The button label needs: data-split-button-target="label"
// Each option needs: data-split-button-target="option", data-action="split-button#select"

export default class extends Controller {
  static targets = ["form", "label", "option"]
  static values = { selected: { type: Number, default: 0 } }

  connect() {
    this.#updateVisibility()
  }

  select(event) {
    const option = event.currentTarget
    const index = this.optionTargets.indexOf(option)
    if (index === -1) return

    this.selectedValue = index
    this.formTarget.action = option.dataset.actionValue
    this.labelTarget.textContent = option.dataset.labelValue
    this.#updateVisibility()
    this.#closeDropdown()
  }

  #updateVisibility() {
    this.optionTargets.forEach((el, i) => {
      el.classList.toggle("hidden", i === this.selectedValue)
    })
  }

  #closeDropdown() {
    const dropdownEl = this.element.querySelector("[data-controller*='ruby-ui--dropdown-menu']")
    if (dropdownEl) {
      const controller = this.application.getControllerForElementAndIdentifier(dropdownEl, "ruby-ui--dropdown-menu")
      if (controller) controller.close()
    }
  }
}
