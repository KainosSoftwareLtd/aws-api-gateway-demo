package com.kainos.apigateways.aws.demo.customer;

import com.kainos.apigateways.aws.demo.api.Customer.CustomerResponse;
import com.kainos.apigateways.aws.demo.customer.entities.Customer;

public class Utils {
    public static CustomerResponse convertCustomerToCustomerResponse(Customer customer) {
        CustomerResponse response = new CustomerResponse();
        response.setId(customer.getId());
        response.setName(customer.getName());

        return response;
    }
}
