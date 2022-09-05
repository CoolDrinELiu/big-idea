import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  clicked_bell(){
    document.querySelector("#notification-mark").style.color = ""
  }
}