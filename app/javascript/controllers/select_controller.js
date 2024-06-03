import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

export default class extends Controller {
  static targets = ["date", "hour", "partySize", "business", "time"]
  static values = {
    url: String
  }
  change() {
    let params = new URLSearchParams();
    params.append("target", this.timeTarget.id);
    params.append("business_id", this.businessTarget.value);
    params.append("party_size", this.partySizeTarget.value);
    params.append("date", this.dateTarget.value);
    params.append("hour", this.hourTarget.value);

    get(`${this.urlValue}?${params}`, {
      responseKind: "turbo-stream"
    }); 
  }
}
