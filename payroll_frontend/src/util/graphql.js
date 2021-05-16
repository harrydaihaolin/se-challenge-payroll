import { gql } from "graphql-tag";
import { createHttpLink, ApolloClient, InMemoryCache } from "@apollo/client";

const httpLink = createHttpLink({ uri: `${process.env.REACT_APP_BACKEND_URL}/graphql` });

export const createClient = () => {
  return new ApolloClient({
    // we will change this later when setting up the socket
    link: httpLink,
    cache: new InMemoryCache(),
  });
};

export const GET_RATES_FROM_JOB_GROUP = gql`
query {
  getJobGroups {
    name
    rate
  }
}
`

export const GET_JOB_GROUPS = gql`
query {
    getJobGroups {
        name
        rate
        insertedAt
        updatedAt
    }
}
`

export const INSERT_JOB_GROUPS = gql`
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

export const INSERT_EMPLOYEE = gql`
mutation($employeeId: Int!) {
    insertEmployee(input: {
        employeeId: $employeeId
    }) {
        employeeId
    }
  }
`

export const INSERT_REPORT = gql`
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

export const INSERT_RECORD = gql`
mutation(
  $currency: String!,
  $hours: Float!,
  $reportTime: String!,
  $wage: Int!,
	$reportName: String!,
	$reportDate: String!,
	$employeeId: Int!) {
  insertRecord(input: {
    	currency: 	$currency,
    	hours: 			$hours,
    	reportTime: $reportTime,
    	wage: 			$wage,
    	reportName: $reportName,
    	reportDate: $reportDate,
    	employeeId: $employeeId
  }) {
    	currency
    	hours
    	reportTime
    	wage
  }
}
`

export const GET_PAYROLL_REPORT = gql`
query {
  getPayrollReport {
   employeeId
   payPeriod {
     startDate
     endDate
   }
 }
}
`

export const CHECK_REPORT = gql`
query($name: String!, $fileDate: String!) {
  checkReport(input: {
    name: $name,
    fileDate: $fileDate
  })
}
`