import React from 'react'

/** This should match the signature of `Props` in `../../WidgetMinimal.lean` */
interface Props {
  name : string
  count? : number
}

export default function (props : Props) {
  return <div>
    <h2>Hello {props.name}</h2>
    {!!props.count && <p>You have {props.count} emails!</p>}
  </div>
}

// [todo]: add a minimal example of an RPC call (requires @lean4/infoview)