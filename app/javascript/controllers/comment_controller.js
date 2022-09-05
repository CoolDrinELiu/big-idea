import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "replyInfo", "replyIdInput", "replyToName" ]

  set_reply_id(e){
    this.replyInfoTarget.style.display = 'block'
    this.replyIdInputTarget.value = e.target.dataset.vid
    this.replyToNameTarget.textContent = "> Reply to: " + e.target.dataset.uname
    window.scrollTo(0, document.body.scrollHeight);
  }

  cancel_reply(){
    this.replyInfoTarget.style.display = 'none'
    this.replyIdInputTarget.value = null
  }
}