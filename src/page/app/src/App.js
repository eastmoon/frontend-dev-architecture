// Import library
import React from 'react';
import './App.css';
import {Application, Utils} from 'clibs';
import StartupCommand from "./command/startup";
import AppService from './services/app';

// Declare variable

// Declare class
class App extends React.Component {
  //
  constructor(props) {
      super(props);
      this.state = {
          initial: false
      };
      this.startupCmd = null;
  }
  async componentDidMount() {
      if ( this.startupCmd === null && ! this.state.initial ) {
          // Execute startup command
          this.startupCmd = new StartupCommand();
          await this.startupCmd.execute();
          Utils.echoi("Show information message");
          Utils.echow("Show warning message");
          Utils.echoe("Show error message;");
          Utils.echoi("startup complete");
          // App views initial complete, change initial state
          this.setState({initial: true});

      }
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
      //
      let title = ""
      if (Application.models.has(AppService.Name)) {
          Utils.echoi(AppService.Name);
          const as = Application.models.retrieve(AppService.Name);
          console.log(as);
          title = as.message;
      }
      return (
          <div className="w-full h-full p-2">
              {title}
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
