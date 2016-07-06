package com.kainos.apigateways.aws.demo.food.resources;

import com.codahale.metrics.annotation.Timed;
import com.kainos.apigateways.aws.demo.food.db.FoodDao;
import com.kainos.apigateways.aws.demo.food.entities.Food;
import io.dropwizard.hibernate.UnitOfWork;
import io.dropwizard.jersey.params.LongParam;
import org.slf4j.Logger;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.util.List;

@Path("/food")
@Produces(MediaType.APPLICATION_JSON)
public class FoodResource {

    private final FoodDao foodDao;
    private final Logger logger;

    public FoodResource(FoodDao foodDao, Logger logger) {
        this.foodDao = foodDao;
        this.logger = logger;
    }

    @GET
    @Path("/{id}")
    @Timed
    @UnitOfWork
    public Food findFood(@PathParam("id") LongParam id) {
        throwIfFoodNotFound(id.get());
        return foodDao.findById(id.get());
    }

    @GET
    @Timed
    @UnitOfWork
    @Path("/allForCustomer/{customerId}")
    public List<Food> allFoodForCustomer(@PathParam("customerId") LongParam customerId) {
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
        throwIfFoodNotFound(id.get());
        foodDao.delete(id.get());
    }

    @Path("/{id}")
    @PUT
    @UnitOfWork
    @Consumes({MediaType.APPLICATION_JSON})
    @Produces({MediaType.APPLICATION_JSON})
    public boolean update(@PathParam("id") LongParam id, Food food) {
        throwIfFoodNotFound(id.get());
        foodDao.update(id.get(), food);
        return true;
    }


    /**
     * Throw BadRequestException if food with given foodId doesn't exist.
     * Client will receive a response (400 Bad Request) with an error message.
     *
     * @param foodId Food identifier
     */
    private void throwIfFoodNotFound(Long foodId) {
        if (!foodDao.exists(foodId)) {
            String message = "Food with id = " + foodId + " does not exist";
            logger.debug(message);
            throw new BadRequestException(message);
        }
    }
}
