import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = ["button", "collection"]
  static classes = ["change"]
  connect() {
    document.addEventListener('turbo:before-stream-render', this.handleTurboStream.bind(this));
  }

  update(event) {
    this.resetAll();
    event.target.classList.add(this.changeClass);
  }

  resetAll() {
    this.buttonTargets.forEach(button => {
      button.classList.remove(this.changeClass);
    });
  }

  handleTurboStream(event) {
    if(this.createButton(event)) {
      this.resetAll();
    }
  }

  createButton(event) {
    if(event.detail.newStream.action == "append" && event.detail.newStream.target == this.collectionTarget.id) return true
    return false
  }
}
