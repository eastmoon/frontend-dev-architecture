import React from 'react';
import './App.css';
import clibs from 'clibs';

class App extends React.Component {
  //
  constructor(props) {
      super(props);
      console.log(clibs);
      console.log(clibs.pattern);
      clibs.utils.echoi("1234");
      clibs.utils.echow("5678");
      clibs.utils.echoe("0912");
      this.state = {
          initial: false
      };
  }
  // Component render
  renderInit() {
      return (
          <div className="w-full h-full">
              <div className="p-2">
                  <div className="flex items-center p-4 mb-4 text-sm border rounded-lg bg-gray-800 text-green-400 border-green-800">
                      <svg className="flex-shrink-0 inline w-4 h-4 me-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 20 20">
                          <path d="M10 .5a9.5 9.5 0 1 0 9.5 9.5A9.51 9.51 0 0 0 10 .5ZM9.5 4a1.5 1.5 0 1 1 0 3 1.5 1.5 0 0 1 0-3ZM12 15H8a1 1 0 0 1 0-2h1v-3H8a1 1 0 0 1 0-2h2a1 1 0 0 1 1 1v4h1a1 1 0 0 1 0 2Z"/>
                      </svg>
                      <div>
                          系統啟動中 ...
                      </div>
                  </div>
              </div>
          </div>
      )
  }
  renderApp() {
      return (
          <div className="w-full h-full">
              Hello world !!!!
          </div>
      )
  }
  render() {
    return (
      <div className="p-2 App">
        <h1 className="text-3xl font-bold">Frontend Develop architecture</h1>
        { ! this.state.initial ? this.renderInit() : this.renderApp()}
      </div>
    );
  }
}

export default App;
