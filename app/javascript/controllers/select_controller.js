import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

export default class extends Controller {
  static targets = ["date", "hour", "partySize", "business", "time"]
  change() {
    let target = this.timeTarget.id
    get(`/reservations/available?target=${target}&business_id=${this.businessTarget.value}&party_size=${this.partySizeTarget.value}&date=${this.dateTarget.value}&hour=${this.hourTarget.value}`, {
      responseKind: "turbo-stream"
    }); 
  }
}
