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
    this.openValue ? this.open(false) : this.close(false)
  }

  toggle() {
    this.openValue = !this.openValue
  }

  openValueChanged(isOpen, wasOpen) {
    if (wasOpen === undefined) return
    isOpen ? this.open(true) : this.close(true)
  }

  open(animate = true) {
    if (!this.hasContentTarget) return
    const el = this.contentTarget
    el.classList.remove('hidden')

    if (animate) {
      el.style.height = '0px'
      el.style.overflow = 'hidden'
      void el.offsetHeight
      requestAnimationFrame(() => {
        el.style.transition = 'height 200ms ease-out'
        el.style.height = el.scrollHeight + 'px'
        const handler = (e) => {
          if (e.target !== el) return
          el.removeEventListener('transitionend', handler)
          el.style.height = ''
          el.style.overflow = ''
          el.style.transition = ''
        }
        el.addEventListener('transitionend', handler)
      })
    }

    if (this.hasIconTarget) {
      this.iconTarget.style.transform = 'rotate(0deg)'
    }
    this.openValue = true
  }

  close(animate = true) {
    if (!this.hasContentTarget) return
    const el = this.contentTarget

    if (animate) {
      el.style.height = el.scrollHeight + 'px'
      el.style.overflow = 'hidden'
      requestAnimationFrame(() => {
        el.style.transition = 'height 200ms ease-out'
        el.style.height = '0px'
        const handler = (e) => {
          if (e.target !== el) return
          el.removeEventListener('transitionend', handler)
          el.classList.add('hidden')
          el.style.height = ''
          el.style.overflow = ''
          el.style.transition = ''
        }
        el.addEventListener('transitionend', handler)
      })
    } else {
      el.classList.add('hidden')
    }

    if (this.hasIconTarget) {
      this.iconTarget.style.transform = 'rotate(-90deg)'
    }
    this.openValue = false
  }
}
