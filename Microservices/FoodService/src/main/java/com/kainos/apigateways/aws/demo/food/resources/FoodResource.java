package com.kainos.apigateways.aws.demo.food.resources;

import com.codahale.metrics.annotation.Timed;
import com.kainos.apigateways.aws.demo.food.db.FoodDao;
import com.kainos.apigateways.aws.demo.food.entities.Food;
import io.dropwizard.hibernate.UnitOfWork;
import io.dropwizard.jersey.params.LongParam;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.util.List;

/**
 * Created by adrianz on 21/06/16.
 */

@Path("/food")
@Produces(MediaType.APPLICATION_JSON)
public class FoodResource {

    private final FoodDao foodDao;

    public FoodResource(FoodDao foodDao) {
        this.foodDao = foodDao;
    }

    @GET
    @Path("/{id}")
    @Timed
    @UnitOfWork
    public Food findFood(@PathParam("id")  LongParam id) {
        return foodDao.findById(id.get());
    }

    @GET
    @Timed
    @UnitOfWork
    @Path("/allForCustomer/{customerId}")
    public List<Food> allFoodForCustomer(@PathParam("customerId")  LongParam customerId) {
        return foodDao.findForCustomer(customerId.get());
    }

        @POST
    @Timed
    @UnitOfWork
    public long createFood(@FormParam("customerId") Long customerId,
                           @FormParam("name") String name,
                           @FormParam("quantity") double quantity,
                           @FormParam("price") int price) {

        return foodDao.create(new Food(customerId, name, quantity, price));
    }

    @DELETE
    @Path("/{id}")
    @UnitOfWork
    public void delete(@PathParam("id") LongParam id) {
        foodDao.delete(id.get());
    }

    @Path("/{id}")
    @PUT
    @UnitOfWork
    @Consumes({MediaType.APPLICATION_JSON})
    @Produces({MediaType.APPLICATION_JSON})
    public boolean update(@PathParam("id") LongParam id, Food food) {
        if (foodDao.exists(id.get())) {
            foodDao.update(id.get(), food);
            return true;
        } else {
            return false;
        }
    }

}
