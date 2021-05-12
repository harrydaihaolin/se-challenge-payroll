import Papa from 'papaparse';
import { useCallback } from 'react';

export const fileInfo = (file) => {
    return {
        name: file.name,
        date: file.lastModifiedDate
    }
}
// import sample from '../assets/time-report-42.csv';
export const csvParser = (file, callback) => {
    console.log("csv parser parsing...")
    Papa.parse(file, {
        header: false,
        download: true,
        step: (row) => callback(row),
        complete: function() {
            console.log("All done!");
        }
    });
}

