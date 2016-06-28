package com.kainos.apigateways.aws.demo.food.entities;

import com.fasterxml.jackson.annotation.JsonProperty;
import org.hibernate.validator.constraints.Length;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.validation.constraints.Min;

/**
 * Created by adrianz on 21/06/16.
 */

@Entity
public class Food {

    @Id @GeneratedValue
    @JsonProperty
    private Long id;

    private Long customerId;

    @Length(min = 2)
    @JsonProperty
    private String name;

    @Min(value = 0)
    @JsonProperty
    private Double quantity;

    @Min(value = 0)
    @JsonProperty
    private Integer price;

    public Food(Long customerId, String name, Double quantity, int price) {
        this.customerId = customerId;
        this.name = name;
        this.quantity = quantity;
        this.price = price;
    }

    public Food() {}

    public Long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public Double getQuantity() {
        return quantity;
    }

    public Integer getPrice() {
        return price;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setQuantity(Double quantity) {
        this.quantity = quantity;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }

    public Long getCustomerId() { return customerId; }

    public void setCustomerId(Long customerId) { this.customerId = customerId; }
}
