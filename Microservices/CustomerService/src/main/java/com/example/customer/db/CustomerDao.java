package com.example.customer.db;

import com.example.customer.api.Customer;
import io.dropwizard.hibernate.AbstractDAO;
import org.hibernate.Query;
import org.hibernate.SessionFactory;

/**
 * Created by adrianz on 21/06/16.
 */
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

    public void update(Long id, Customer customer) {

        Customer updatedCustomer = get(id);

        if (customer.getName() != null) {
            updatedCustomer.setName(customer.getName());
        }

        currentSession().update(updatedCustomer);
    }

}
