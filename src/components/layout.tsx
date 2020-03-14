import * as React from 'react';
import 'normalize.css'

export const Layout: React.FunctionComponent<{}> = ({children}) => {
  return (<>
    <div id='wrapper'>
      {children}
    </div>
  </>);
}
