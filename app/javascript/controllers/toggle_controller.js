import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = ["button"]
  static classes = ["change"]
  connect() {
    console.log(this.changeClass);
  }

  update(event) {
    this.resetAll();
    event.target.classList.add(this.changeClass);
  }

  resetAll() {
    console.log(this.buttonTargets);
    this.buttonTargets.forEach(button => {
      button.classList.remove(this.changeClass);
    });
  }
}
