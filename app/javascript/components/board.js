import { Component } from 'react'
import h from "components/htm_create_element"

export default class Board extends Component{
  constructor(props) {
    super(props);
  }
  renderSquare(i) {
    console.log(this.props.onClick)
      return h`
      
      <${Square} value=${ this.props.squares[i] }
        onClick=${ () => this.props.onClick(i) }
      />
    `;
  }

  render() {
    return h`
      <div>
        <div className="board-row">
          ${this.renderSquare(0)}
          ${this.renderSquare(1)}
          ${this.renderSquare(2)}
        </div>
        <div className="board-row">
          ${this.renderSquare(3)}
          ${this.renderSquare(4)}
          ${this.renderSquare(5)}
        </div>
        <div className="board-row">
          ${this.renderSquare(6)}
          ${this.renderSquare(7)}
          ${this.renderSquare(8)}
        </div>
      </div>`
  }
}

function Square(props) {
  return (
    h`<button className="square" onClick=${props.onClick}>
      ${props.value}
    </button>`
  );
}