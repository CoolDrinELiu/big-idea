import { Component } from 'react'
import h from "components/htm_create_element"
import axios from "axios";

export default class Hello extends Component{
  constructor(props) {
    super(props);
    this.state = {
      hi_msg: null
    };
  }

  say_hi() {
    axios
    .get('/api/hello')
    .then((res) => { this.setState({hi_msg: res.data.message}) })
    .catch((error) => console.log(error));
    console.log(this.state.hi_msg);
  }

  render() {
    return h`
        <div className="board-row" onClick=${ () => this.say_hi() }>
          ------- ${ this.state.hi_msg } -------
        </div>`
  }
}
