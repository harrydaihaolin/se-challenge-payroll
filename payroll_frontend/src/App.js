import './App.css';
import logo from './assets/logo.png';
import { Grid} from '@material-ui/core';
import { useEffect, useState } from 'react';
import { DropzoneAreaBase } from 'material-ui-dropzone';
import { AttachFile} from '@material-ui/icons';
import { csvParser, fileInfo } from './util/csvParser';
import {INSERT_EMPLOYEE, INSERT_RECORD, INSERT_REPORT, GET_RATES_FROM_JOB_GROUP} from './util/graphql';
import { useMutation, useQuery} from '@apollo/client';

function App() {
  // queries and mutations
  const [map, setMap] = useState({});
  const {data: rates, loading: rates_loading} = useQuery(GET_RATES_FROM_JOB_GROUP);
  const [insertReport, {loading: report_loading}] = useMutation(INSERT_REPORT);
  const [insertEmployee, {loading: employee_loading}] = useMutation(INSERT_EMPLOYEE);
  const [insertRecord, {loading: record_loading}] = useMutation(INSERT_RECORD);

  useEffect(() => {
    !rates_loading && setMap(rates.getJobGroups.reduce((map, obj) => (map[obj.name] = obj.rate, map), {}));
  }, [rates]);

  const handleFileUpload = async (files) => {
      // processing reports
      const file = files[0].file;
      const info = fileInfo(file);
      insertReport({variables: {
        name: info.name,
        fileDate: info.date
      }})
      // processing job_groups, employees and records
      await csvParser(file, (row) => {
        // skip header
        if (row.data[0] !== "date" && row.data[0] !== "") {
          // console.log(row.data);
          const date = row.data[0];
          const hours_worked = row.data[1];
          const job_group_name = row.data[3];
          const price = map[job_group_name];

          const employee_id = row.data[2];
          // processing records
          insertRecord({
            variables: {
              currency: price.charAt(0) ,
              hours: parseFloat(hours_worked),
              reportTime: date,
              wage: parseInt(price.slice(1)),
              employeeId: parseInt(employee_id),
              reportName: info.name,
              reportDate: info.date
            }
          }).then((data) => console.log(data))
        }
      });
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
              <DropzoneAreaBase
                Icon={AttachFile}
                filesLimit={1}
                acceptedFiles={['.csv']}
                dropzoneText={"Drag and drop an csv file here or click"}
                onAdd={(files) => handleFileUpload(files)}
                onAlert={(message, variant) =>
                  console.log(`${variant}: ${message}`
                )
              }
              />
          </Grid>
        </Grid>
      </div>
    );
}

export default App;
