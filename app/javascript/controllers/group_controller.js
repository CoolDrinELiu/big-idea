import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const modal = document.querySelector("[data-modal-toggle='new-group-modal']");
    let seconds = 2;
    let countdown = function() {
      var setIntervalHandler = setInterval(function () {
        document.querySelector("#timer").innerHTML = "(" + seconds + ")"
        seconds -- ;
        if(seconds < -1) {
          clearInterval(setIntervalHandler);
          document.querySelector("#close-notification").click();
          document.querySelector("#group_name").value = ""
          modal.click()
        }

      }, 1000)
    };
    countdown()
  }
}