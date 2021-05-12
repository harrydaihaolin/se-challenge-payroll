import { gql } from "graphql-tag";


const GET_JOB_GROUPS = gql`
query {
    getJobGroups {
        name
        rate
        insertedAt
        updatedAt
    }
}
`

const INSERT_JOB_GROUPS = gql`
mutation($name: String!, $rate: String!) {
    insertJobGroups(input: {
      name: $name,
      rate: $rate
    }) {
      name
      rate
      insertedAt
      updatedAt
    }
  }
`

const INSERT_EMPLOYEE = gql`
mutation($employeeId: Int!) {
    insertEmployee(input: {
        employeeId: $employeeId
    }) {
        employeeId
    }
  }
`

const INSERT_REPORT = gql`
mutation($name: String!, $fileDate: String!) {
    insertReports(input: {
        name: $name,
        fileDate: $fileDate
    }) {
      name
      fileDate
      insertedAt
      updatedAt
    }
  }
`

const INSERT_RECORD = gql`
mutation($currency: String!, $hours: Int!, $reportTime: String!, $wage: Int!, $employeeId: Int!, $reportId: Int!) {
    insertRecord(input: {
      currency: $currency,
      hours: $hours,
      reportTime: $reportTime,
      wage: $wage,
      employeeId: $employeeId,
      reportId: $reportId
    }) {
        currency
      hours
      reportTime
      wage
      insertedAt
      updatedAt
    }
  }
`

export default function Apollo() {
    return {
        GET_JOB_GROUPS,
        INSERT_EMPLOYEE,
        INSERT_JOB_GROUPS,
        INSERT_RECORD,
        INSERT_REPORT
    }
}