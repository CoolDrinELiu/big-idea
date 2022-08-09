import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "data" ]
  set_reply_id(){
    let reply_id = this.element.dataset.vid
    let reply_name = this.element.dataset.uname
    let reply_info = document.querySelector("#reply-info")
    let reply_id_input = document.getElementById("comment_reply_id")
    let reply_ele = document.getElementById("reply-to-name")

    reply_info.style.display = 'block'
    reply_id_input.value = reply_id
    reply_ele.textContent = "> Reply to: " + reply_name
    window.scrollTo(0, document.body.scrollHeight);
  }

  cancel_reply(){
    let reply_info = document.querySelector("#reply-info")
    let reply_id_input = document.getElementById("comment_reply_id")

    reply_info.style.display = 'none'
    reply_id_input.value = null
  }
}