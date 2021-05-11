import './App.css';
import logo from './assets/logo.png';
// import { getRates } from './Apollo';
// import { csvParser, getFileTimestamp } from './util/csvParser';
import { Grid } from '@material-ui/core';
import { DropzoneAreaBase } from 'material-ui-dropzone';
import { AttachFile } from '@material-ui/icons';
import { csvParser, fileInfo } from './util/csvParser';


function App() {

  const handleFileUpload = (files) => {
      const path = files[0].file;
      path && console.log(path.lastModified);
      path && csvParser(path);
  }

  return (
    <div className="App">
      <Grid 
        container
        spacing={0}
        direction="column"
        alignItems="center"
        justify="center">
        <Grid item>
          <img src={logo} className="App-logo" alt="logo" />
        </Grid>
        <Grid item>
            {/* <Button onClick={() => handleFileUpload()}>Click</Button>s */}
            <DropzoneAreaBase
              Icon={AttachFile}
              filesLimit={1}
              acceptedFiles={['.csv']}
              dropzoneText={"Drag and drop an csv file here or click"}
              // onChange={(files) => console.log(files)}
              onAdd={(files) => handleFileUpload(files)}
              onAlert={(message, variant) => console.log(`${variant}: ${message}`)}
            />
        </Grid>
      </Grid>

    </div>
  );
}

export default App;
