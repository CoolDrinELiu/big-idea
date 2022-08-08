import { render } from "react-dom"
import h from "components/htm_create_element"

import Wysiwyg from "components/wysiwyg"

const target1 = document.getElementById("wysiwyg-box-post")
const target2 = document.getElementById("wysiwyg-box-comment")

if(target1 !== null){
  render(
    h `<${Wysiwyg} name=${ 'post[content]' } />`,
    document.getElementById("wysiwyg-box-post")
  )
}

if(target2 !== null){
  render(
    h `<${Wysiwyg} name=${ 'comment[content]' } />`,
    document.getElementById("wysiwyg-box-comment")
  )
}