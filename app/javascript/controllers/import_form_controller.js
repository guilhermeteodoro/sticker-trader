import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dump", "manual"]

  toggle(event) {
    const method = event.target.value
    if (method === "dump") {
      this.dumpTarget.classList.remove("hidden")
      this.manualTarget.classList.add("hidden")
    } else {
      this.dumpTarget.classList.add("hidden")
      this.manualTarget.classList.remove("hidden")
    }
  }
}
