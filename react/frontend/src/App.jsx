import { useState } from 'react'
import reactLogo from './assets/react.svg'
import viteLogo from '/vite.svg'
import './App.css'

function App() {
  return (
    <>
      <Text display="kuba"/>
      <Text display="klaudia"/>
    </>

  )
}


function Text({display}) {
  return (
    <div>
      <p>hello world {display}</p>
    </div>
  )
}

export default App
