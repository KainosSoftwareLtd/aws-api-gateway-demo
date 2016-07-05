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

    //TODO: mark as foreign key?
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

    @Override
    public String toString() {
        return "Food{" +
                "id=" + id +
                ", customerId=" + customerId +
                ", name='" + name + '\'' +
                ", quantity=" + quantity +
                ", price=" + price +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Food food = (Food) o;

        if (getId() != null ? !getId().equals(food.getId()) : food.getId() != null) return false;
        if (getCustomerId() != null ? !getCustomerId().equals(food.getCustomerId()) : food.getCustomerId() != null)
            return false;
        if (!getName().equals(food.getName())) return false;
        if (!getQuantity().equals(food.getQuantity())) return false;
        return getPrice().equals(food.getPrice());

    }

    @Override
    public int hashCode() {
        int result = getId() != null ? getId().hashCode() : 0;
        result = 31 * result + (getCustomerId() != null ? getCustomerId().hashCode() : 0);
        result = 31 * result + getName().hashCode();
        result = 31 * result + getQuantity().hashCode();
        result = 31 * result + getPrice().hashCode();
        return result;
    }
}
