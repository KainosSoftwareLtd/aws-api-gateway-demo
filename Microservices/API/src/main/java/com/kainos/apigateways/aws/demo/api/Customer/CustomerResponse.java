package com.kainos.apigateways.aws.demo.api.Customer;

import com.fasterxml.jackson.annotation.JsonProperty;

public class CustomerResponse {

    @JsonProperty
    private Long id;

    @JsonProperty
    private String name;

    public CustomerResponse(String name) {
        this.name = name;
    }

    public CustomerResponse() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "CustomerResponse{" +
                "id=" + id +
                ", name='" + name + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        CustomerResponse customer = (CustomerResponse) o;

        return getId() != null ? getId().equals(customer.getId()) : customer.getId() == null && getName().equals(customer.getName());
    }

    @Override
    public int hashCode() {
        int result = getId() != null ? getId().hashCode() : 0;
        result = 31 * result + getName().hashCode();
        return result;
    }
}