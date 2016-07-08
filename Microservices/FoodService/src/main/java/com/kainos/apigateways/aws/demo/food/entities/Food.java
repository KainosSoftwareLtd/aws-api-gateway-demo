package com.kainos.apigateways.aws.demo.food.entities;

import com.fasterxml.jackson.annotation.JsonProperty;
import org.hibernate.validator.constraints.Length;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.validation.constraints.Min;

@Entity
public class Food {

    @Id
    @GeneratedValue
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

    public Food() {
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

    public Double getQuantity() {
        return quantity;
    }

    public void setQuantity(Double quantity) {
        this.quantity = quantity;
    }

    public Integer getPrice() {
        return price;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }

    public Long getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Long customerId) {
        this.customerId = customerId;
    }

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
        if (getName() != null ? !getName().equals(food.getName()) : food.getName() != null) return false;
        if (getQuantity() != null ? !getQuantity().equals(food.getQuantity()) : food.getQuantity() != null)
            return false;
        return getPrice() != null ? getPrice().equals(food.getPrice()) : food.getPrice() == null;

    }

    @Override
    public int hashCode() {
        int result = getId() != null ? getId().hashCode() : 0;
        result = 31 * result + (getCustomerId() != null ? getCustomerId().hashCode() : 0);
        result = 31 * result + (getName() != null ? getName().hashCode() : 0);
        result = 31 * result + (getQuantity() != null ? getQuantity().hashCode() : 0);
        result = 31 * result + (getPrice() != null ? getPrice().hashCode() : 0);
        return result;
    }
}
