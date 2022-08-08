import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const targetEl = document.querySelector(this.element.getAttribute('data-dismiss-target'))

    new Dismiss(targetEl, {
      triggerEl: this.element
    })
  }
}