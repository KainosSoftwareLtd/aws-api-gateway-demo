package com.example.food.api;

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
    private Long id;

    @Length(min = 2)
    private String name;

    @Min(value = 0)
    private Double quantity;

    @Min(value = 0)
    private Integer price;


    public Food(String name, Double quantity, int price) {
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
}
