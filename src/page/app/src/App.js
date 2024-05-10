import logo from './logo.svg';
import './App.css';
import clibs from 'clibs';

function App() {
  console.log(clibs);
  clibs.utils.echoi("1234");
  clibs.utils.echow("5678");
  clibs.utils.echoe("0912");
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.js</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React 123
        </a>
      </header>
    </div>
  );
}

export default App;
