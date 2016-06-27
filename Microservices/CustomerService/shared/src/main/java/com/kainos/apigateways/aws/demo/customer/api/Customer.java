package com.kainos.apigateways.aws.demo.customer.api;

import com.fasterxml.jackson.annotation.JsonProperty;
import org.hibernate.validator.constraints.Length;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

/**
 * Created by adrianz on 21/06/16.
 */

@Entity
public class Customer {

    @Id @GeneratedValue
    private Long id;

    @Length(min = 2)
    private String name;

    public Customer(String name) {
        this.name = name;
    }

    public Customer() {
        //deserialization
    }

    @JsonProperty
    public Long getId() {
        return id;
    }

    @JsonProperty
    public String getName() {
        return name;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }
}
