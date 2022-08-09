
import { Controller } from "@hotwired/stimulus"
import consumer from 'channels/consumer';

export default class extends Controller {

  connect() {
    this.channel = consumer.subscriptions.create({ channel: "UserNotificationChannel", user_id: this.data.get('userid') }, {
        connected: this._cableConnected.bind(this),
        disconnected: this._cableDisconnected.bind(this),
        received: this._cableReceived.bind(this),
      });
    }
    _cableConnected() {
      console.log('Connected');
    }

    _cableDisconnected() {
      console.log('Disconnected');
    }

    _cableReceived(data) {
      console.log('From Action Cable: ' + data.message);
      document.querySelector("#notification-mark").style.color = "red"
    }

}