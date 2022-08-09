import { Component } from "react";
import h from "components/htm_create_element"

export default class Wysiwyg extends Component{
  constructor(props) {
    super(props);
  }

  render() {
    return h`
        <div>
            <input
                name="${this.props.name}"
                type="hidden"
                id="trix"
            />
            <trix-editor input="trix" />
        </div>`
  }
}