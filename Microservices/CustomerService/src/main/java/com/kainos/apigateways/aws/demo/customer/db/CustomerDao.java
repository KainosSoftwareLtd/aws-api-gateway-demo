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

    public void update(Customer customer) {
        currentSession().update(customer);
    }
}
