import Papa from 'papaparse';

export const fileInfo = (file) => {
    console.log(file)
}
// import sample from '../assets/time-report-42.csv';
export const csvParser = (file) => {
    console.log("csv parser parsing...")
    Papa.parse(file, {
        header: false,
        download: true,
        step: function(row) {
            console.log("Row:", row.data);
        },
        complete: function() {
            console.log("All done!");
        }
    });
}