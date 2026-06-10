import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "label"]

  switchToAuto() {
    this.formTarget.action = this.formTarget.dataset.autoAction
    this.labelTarget.textContent = this.labelTarget.dataset.autoLabel
  }

  switchToDefault() {
    this.formTarget.action = this.formTarget.dataset.defaultAction
    this.labelTarget.textContent = this.labelTarget.dataset.defaultLabel
  }
}
