package com.kainos.apigateways.aws.demo.food.resources;

import com.codahale.metrics.annotation.Timed;
import com.kainos.apigateways.aws.demo.food.db.FoodDao;
import com.kainos.apigateways.aws.demo.food.entities.Food;
import io.dropwizard.hibernate.UnitOfWork;
import io.dropwizard.jersey.params.LongParam;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.util.List;

@Path("/food")
@Produces(MediaType.APPLICATION_JSON)
public class FoodResource {

    private static final Logger logger = LoggerFactory.getLogger(FoodResource.class);
    private final FoodDao foodDao;

    public FoodResource(FoodDao foodDao) {
        this.foodDao = foodDao;
    }

    @GET
    @Path("/{id}")
    @Timed
    @UnitOfWork(readOnly = true)
    public Food find(@PathParam("id") LongParam id) {
        throwIfFoodNotFound(id.get());
        return foodDao.findById(id.get());
    }

    @GET
    @Timed
    @UnitOfWork(readOnly = true)
    @Path("/allForCustomer/{customerId}")
    public List<Food> allForCustomer(@PathParam("customerId") LongParam customerId) {
        return foodDao.findForCustomer(customerId.get());
    }

    @POST
    @Timed
    @UnitOfWork
    @Consumes({MediaType.APPLICATION_JSON})
    @Produces({MediaType.APPLICATION_JSON})
    public long create(Food food) {
        return foodDao.create(food);
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
        food = fillNullFieldsWithOriginalValues(id.get(), food);
        foodDao.update(food);
        return true;
    }

    @Path("/buy/{id}")
    @POST
    @Timed
    @UnitOfWork
    public boolean buy(@PathParam("id") LongParam id,
                    @FormParam("customerId") Long customerId) {
        throwIfFoodNotFound(id.get());
        Food food = foodDao.findById(id.get());
        logger.debug("Buying Food for Customer with id=" + customerId);

        if (customerId == null){
            logger.warn("No customerId provided in a buy request");
            return false;
        }
        logger.trace("Food that will be bought: " + food);
        foodDao.update(food);
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

    /**
     * Prevent updated Food from having null fields that appear when some values were unspecified
     *
     * @param originalFoodId        Id of food which fields will fill any null values
     * @param foodUpdatedFieldsOnly Food with updated or null values that came from a request
     * @return Food with null values replaced by original ones
     */
    private Food fillNullFieldsWithOriginalValues(Long originalFoodId, Food foodUpdatedFieldsOnly) {
        logger.debug("Filling null fields of an updated Food (foodId=" + originalFoodId + ") with original values");
        logger.trace("Food fields that will be updated: " + foodUpdatedFieldsOnly);

        Food originalFood = foodDao.findById(originalFoodId);

        if (foodUpdatedFieldsOnly.getPrice() != null) {
            originalFood.setPrice(foodUpdatedFieldsOnly.getPrice());
        }
        if (foodUpdatedFieldsOnly.getName() != null) {
            originalFood.setName(foodUpdatedFieldsOnly.getName());
        }
        if (foodUpdatedFieldsOnly.getQuantity() != null) {
            originalFood.setQuantity(foodUpdatedFieldsOnly.getQuantity());
        }
        logger.trace("Food with updated values: " + originalFood);
        return originalFood;
    }
}