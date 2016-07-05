package com.kainos.apigateways.aws.demo.customer.entities;

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

    @JsonProperty
    @Id @GeneratedValue
    private Long id;

    @Length(min = 2)
    @JsonProperty
    private String name;

    public Customer(String name) {
        this.name = name;
    }

    public Customer() {}

    public Long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "Customer{" +
                "id=" + id +
                ", name='" + name + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Customer customer = (Customer) o;

        if (getId() != null ? !getId().equals(customer.getId()) : customer.getId() != null) return false;
        return getName().equals(customer.getName());

    }

    @Override
    public int hashCode() {
        int result = getId() != null ? getId().hashCode() : 0;
        result = 31 * result + getName().hashCode();
        return result;
    }
}
