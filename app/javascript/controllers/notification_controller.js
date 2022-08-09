import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "data" ]
  clicked_bell(){
    document.querySelector("#notification-mark").style.color = ""
  }

}