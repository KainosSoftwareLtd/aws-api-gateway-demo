package com.kainos.apigateways.aws.demo.food.clients;

import com.kainos.apigateways.aws.demo.api.Customer.CustomerResponse;


import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

public class CustomerClient {
    private String basePath;
    private Client client;

    public CustomerClient(String basePath) {
        this.basePath = basePath;
        client = ClientBuilder.newClient();
    }

    public String getBasePath() {
        return basePath;
    }

    public void setBasePath(String basePath) {
        this.basePath = basePath;
    }

    public CustomerResponse getCustomer(Long id) {
        WebTarget webTarget = client.target(basePath).path("customer").path(id.toString());
        Response response = webTarget.request(MediaType.APPLICATION_JSON).get();

        if (response.getStatus() == 400) {
            return null;
        }
        CustomerResponse customerResponse = response.readEntity(CustomerResponse.class);
        return customerResponse;
    }
}
