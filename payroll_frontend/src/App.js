import './App.css';
import logo from './assets/logo.png';
import { Grid, Button } from '@material-ui/core';
import { DropzoneAreaBase } from 'material-ui-dropzone';
import { AttachFile } from '@material-ui/icons';
import { csvParser, fileInfo } from './util/csvParser';
import { ApolloProvider, ApolloClient, InMemoryCache, useMutation} from '@apollo/client'
import GQL from './Apollo'

function App() {
  // queries and mutations
  const [insertReport] = useMutation(GQL.INSERT_REPORT);

  const client = new ApolloClient({
    uri: process.env.REACT_APP_BACKEND_URL,
    cache: new InMemoryCache()
  });

  // const [insertReport] = useMutation(INSERT_REPORT);
  const handleFileUpload = (files) => {
      // processing reports
      const file = files[0].file;
      const info = fileInfo(file);
      insertReport({variables: {
        name: info.name,
        fileDate: info.fileDate
      }})
      // processing employees and records
      file && csvParser(file, (row) => {
        console.log(row)
      });
  }

  return (
    <ApolloProvider client={client}>
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
              {/* <Button onClick={() => test()}>Click</Button> */}
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
    </ApolloProvider>
  );
}

export default App;
