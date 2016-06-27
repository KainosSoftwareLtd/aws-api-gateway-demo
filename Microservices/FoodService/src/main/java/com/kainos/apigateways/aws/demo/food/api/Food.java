package com.kainos.apigateways.aws.demo.food.api;

import com.fasterxml.jackson.annotation.JsonProperty;
import org.hibernate.validator.constraints.Length;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.validation.constraints.Min;

/**
 * Created by adrianz on 21/06/16.
 */

@Entity
public class Food {

    @Id @GeneratedValue
    private Long id;

    @ManyToOne
    private Long customer_id;

    @Length(min = 2)
    private String name;

    @Min(value = 0)
    private Double quantity;

    @Min(value = 0)
    private Integer price;

    public Food(Long customer_id, String name, Double quantity, int price) {
        this.customer_id = customer_id;
        this.name = name;
        this.quantity = quantity;
        this.price = price;
    }

    public Food() {
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

    @JsonProperty
    public Double getQuantity() {
        return quantity;
    }

    @JsonProperty
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

    public Long getCustomer_id() { return customer_id; }

    public void setCustomer_id(Long customer_id) { this.customer_id = customer_id; }
}
