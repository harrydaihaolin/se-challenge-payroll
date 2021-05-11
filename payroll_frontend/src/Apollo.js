import { ApolloClient, InMemoryCache } from '@apollo/client';
import { gql } from "@apollo/client";

const client = new ApolloClient({
  uri: process.env.BACKEND_URL,
  cache: new InMemoryCache()
});

export const getRates = () => {
    client
        .query({
            query: gql`
                query GetRates {
                    rates(currency: "USD") {
                    currency
                    }
                }
            `
        })
        .then(result => console.log(result));
}