import React, {useState, useMemo} from "react";

export default function App(){
  const [number, setNumber] = useState(0);
  const [dark, setDark] = useState(false);
  const doubleNumber = useMemo(()=>
  slowFunction(number),[number]);

  const themeStyles = {
    backgroundColor: dark ? 'black' : 'white',
    color: dark ? 'white' : 'black'
  }

  return (
    <>
    <input type="number" value={number} onChange={e=>setNumber(parseInt(e.target.value))}/>
    <button onClick={()=>setDark(prevDark => !prevDark)}>Change theme</button>
    <div style={themeStyles}>{doubleNumber}</div>
    </>
  );

}

function slowFunction(number) {
  console.log("Calling Slow Function");
  for(let i=0;i<10000000000000;i++){}
  return number*2;
}