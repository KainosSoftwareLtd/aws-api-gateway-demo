package com.kainos.apigateways.aws.demo.customer.db;

import com.kainos.apigateways.aws.demo.customer.entities.Customer;
import io.dropwizard.hibernate.AbstractDAO;
import org.hibernate.Query;
import org.hibernate.SessionFactory;

public class CustomerDao extends AbstractDAO<Customer> {
    public CustomerDao(SessionFactory factory) {
        super(factory);
    }

    public Customer findById(Long id) {
        return get(id);
    }

    public void delete(Long id) {

        Customer customer = findById(id);
        deleteFoodOwnedByCustomer(id);
        currentSession().delete(customer);
    }

    public long create(Customer customer) {
        return persist(customer).getId();
    }

    public Boolean exists(long id) {
        Query query = currentSession().createQuery("select 1 from Customer c where c.id=:id");
        query.setLong("id", id);
        return (query.uniqueResult() != null);
    }

    public void update(Long id, Customer customer) {

        Customer updatedCustomer = get(id);

        if (customer.getName() != null) {
            updatedCustomer.setName(customer.getName());
        }

        currentSession().update(updatedCustomer);
    }

    /**
     * Delete all food entities with given customerId.
     *
     * @param customerId Customer identifier
     * @return The number of deleted entities.
     */
    private int deleteFoodOwnedByCustomer(Long customerId) {
        Query query = currentSession().createQuery("delete from Food f where f.customerId=:customerId");
        query.setLong("customerId", customerId);
        return query.executeUpdate();
    }
}
