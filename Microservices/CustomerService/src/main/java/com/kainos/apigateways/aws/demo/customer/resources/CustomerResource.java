package com.kainos.apigateways.aws.demo.customer.resources;

import com.codahale.metrics.annotation.Timed;
import com.kainos.apigateways.aws.demo.customer.entities.Customer;
import com.kainos.apigateways.aws.demo.customer.db.CustomerDao;
import io.dropwizard.hibernate.UnitOfWork;
import io.dropwizard.jersey.params.LongParam;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;

/**
 * Created by adrianz on 21/06/16.
 */

@Path("/customer")
@Produces(MediaType.APPLICATION_JSON)
public class CustomerResource {

    private final CustomerDao customerDao;

    public CustomerResource(CustomerDao customerDao) {
        this.customerDao = customerDao;
    }

    @GET
    @Path("/{id}")
    @Timed
    @UnitOfWork
    public Customer findCustomer(@PathParam("id")  LongParam id) {
        return customerDao.findById(id.get());
    }

    @POST
    @Timed
    @UnitOfWork
    public long createCustomer(@FormParam("name") String name,
                          @FormParam("quantity") double quantity,
                          @FormParam("price") int price) {
        return customerDao.create(new Customer(name));
    }

    @DELETE
    @Path("/{id}")
    @UnitOfWork
    public void delete(@PathParam("id") LongParam id) {
        customerDao.delete(id.get());
    }

    @Path("/{id}")
    @PUT
    @UnitOfWork
    @Consumes({MediaType.APPLICATION_JSON})
    @Produces({MediaType.APPLICATION_JSON})
    public boolean update(@PathParam("id") LongParam id, Customer customer) {
        if (customerDao.exists(id.get())) {
            customerDao.update(id.get(), customer);
            return true;
        } else {
            return false;
        }
    }

}