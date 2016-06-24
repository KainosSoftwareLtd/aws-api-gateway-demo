package com.example.food.resources;

import com.codahale.metrics.annotation.Timed;
import com.example.food.api.Food;
import com.example.food.db.FoodDao;
import io.dropwizard.hibernate.UnitOfWork;
import io.dropwizard.jersey.params.LongParam;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;

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
    @Timed
    @UnitOfWork
    public Food findFood(@QueryParam("id")  LongParam id) {
        return foodDao.findById(id.get());
    }

    @POST
    @Timed
    @UnitOfWork
    public long createFood(@FormParam("name") String name,
                          @FormParam("quantity") double quantity,
                          @FormParam("price") int price) {
        return foodDao.create(new Food(name, quantity, price));
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
