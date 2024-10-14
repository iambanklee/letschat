import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="messages"
export default class extends Controller {
  clear() {
    this.element.reset();
  }
}
