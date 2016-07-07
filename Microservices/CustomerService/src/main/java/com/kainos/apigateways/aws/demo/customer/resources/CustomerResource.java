package com.kainos.apigateways.aws.demo.customer.resources;

import com.codahale.metrics.annotation.Timed;
import com.kainos.apigateways.aws.demo.customer.db.CustomerDao;
import com.kainos.apigateways.aws.demo.customer.entities.Customer;
import io.dropwizard.hibernate.UnitOfWork;
import io.dropwizard.jersey.params.LongParam;
import org.slf4j.Logger;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;

@Path("/customer")
@Produces(MediaType.APPLICATION_JSON)
public class CustomerResource {

    private final CustomerDao customerDao;
    private final Logger logger;

    public CustomerResource(CustomerDao customerDao, Logger logger) {
        this.customerDao = customerDao;
        this.logger = logger;
    }

    @GET
    @Path("/{id}")
    @Timed
    @UnitOfWork
    public Customer find(@PathParam("id") LongParam id) {
        throwIfCustomerNotFound(id.get());
        return customerDao.findById(id.get());
    }

    @POST
    @Timed
    @UnitOfWork
    public long create(@FormParam("name") String name){
        return customerDao.create(new Customer(name));
    }

    @DELETE
    @Path("/{id}")
    @UnitOfWork
    public void delete(@PathParam("id") LongParam id) {
        throwIfCustomerNotFound(id.get());
        customerDao.delete(id.get());
    }

    @Path("/{id}")
    @PUT
    @UnitOfWork
    @Consumes({MediaType.APPLICATION_JSON})
    @Produces({MediaType.APPLICATION_JSON})
    public boolean update(@PathParam("id") LongParam id, Customer customer) {
        throwIfCustomerNotFound(id.get());
        customer = fillNullFieldsWithOriginalValues(id.get(), customer);
        customerDao.update(id.get(), customer);
        return true;
    }

    /**
     * Throw BadRequestException if customer with given customerId doesn't exist
     * Client will receive a response (400 Bad Request) with an error message
     *
     * @param customerId Customer identifier
     */
    private void throwIfCustomerNotFound(Long customerId) {
        if (!customerDao.exists(customerId)) {
            String message = "Customer with id = " + customerId + " does not exist";
            logger.warn(message);
            throw new BadRequestException(message);
        }
    }
    /**
     * Prevent updated Customer from having null fields that appear when some values were unspecified
     *
     * @param originalCustomerId Id of customer which fields will fill any null values
     * @param originalCustomerId Id of customer which fields will fill any null values
     * @param newCustomer        Customer with updated or null values that came from a request
     * @return Customer with null values replaced by original ones
     */
    private Customer fillNullFieldsWithOriginalValues(Long originalCustomerId, Customer newCustomer) {
        logger.debug("Filling null fields of an updated customer (customerId=" + originalCustomerId + ") with original values");
        logger.trace("Customer fields that will be updated: " + newCustomer);
        Customer originalCustomer = customerDao.findById(originalCustomerId);
        newCustomer.setId(originalCustomerId);
        if (newCustomer.getName() == null) {
            newCustomer.setName(originalCustomer.getName());
        }
        return newCustomer;
    }
}