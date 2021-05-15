# Payroll Project

## Prerequisites
- setup docker environment [setup link](https://docs.docker.com/get-docker/)

## Database Diagram
![Payroll](https://user-images.githubusercontent.com/13538182/117767251-aef47d00-b1fe-11eb-9331-019f73cca522.png)

## Installation Instructions
- Please don't occupy port 5432 in the local, i.e. having another postgresql server in the local

```sh
docker-compose up --build
```

## Endpoints
- everything is deployed in the local
- frontend: localhost:3000 
- backend: localhost:4000
- database: localhost:5432

## Project Description
### Insert Payroll Reports
- I've provided the visualized endpoint in the http://localhost:3000, since I think it makes more sense to parse the csv file in the client end and use Apollo Client to provide abstraction to the data that is eventually going to the database
- Once you see the web interface, either use drag and drop or select the area to upload the file.
- Then you will be able to see the abstracted data in the console log as a reference

### Get Payroll Reports after running at least one insertion of report
- Since this project is based on GraphQL, Here is the curl command for running endpoints of getting payroll report
```curl
curl \
                                                          -X POST \
                                                          -H "Content-Type: application/json" \

                                                          --data '{ "query": "{ getPayrollReport { employeeId payPeriod { startDate endDate } amountPaid } }" }' \
                                                          http://localhost:4000/graphql
```
- Another way to run this is to go to http://localhost:4000/graphiql, which is the interactive test interface for graphql, and run:
```
query {
  getPayrollReport {
   employeeId
   payPeriod {
     startDate
     endDate
   }
  amountPaid
 }
}
```

## Features
#### Data Persistence
- all the data including the report file and date are persisted in the postgresql.
#### Report file specific vs Employee specific
- The default get payroll report feature is for all the employees that all the reports have uploaded to.
- Since there might be multiple reports uploaded, I also optionally implemented the feature that returns thepayroll data specific to the report. I did not enable that in this program.
#### Uniqueness
- All the records, employees, reports are unique by its own combination of attributes.
#### Easiness to setup
- The project is setup by docker compose which is platform agnostic and one click easy. The only dependency is docker environment
#### Future Improvements
- Automation API Tests
	- due to the time requirement of this project, I didn't implement the automated test.
- Production Environment
	- CDN, Nginx server for load performance
- Compromises
	- Normally, I would use TDD/BDD to shift left the tests before development.
	- Automation test coverage
	- Error Handling for unstructured csv data
	- There should be currency exchange, as of now, it is default to dollar

