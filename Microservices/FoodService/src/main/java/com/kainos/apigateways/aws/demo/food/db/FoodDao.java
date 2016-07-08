package com.kainos.apigateways.aws.demo.food.db;

import com.kainos.apigateways.aws.demo.food.entities.Food;
import io.dropwizard.hibernate.AbstractDAO;
import org.hibernate.Query;
import org.hibernate.SessionFactory;

import java.util.List;

public class FoodDao extends AbstractDAO<Food> {
    public FoodDao(SessionFactory factory) {
        super(factory);
    }

    public Food findById(Long id) {
        return get(id);
    }

    public void delete(Long id) {
        Food food = findById(id);
        currentSession().delete(food);
    }

    public long create(Food food) {
        return persist(food).getId();
    }

    public Boolean exists(long id) {
        Query query = currentSession().createQuery("select 1 from Food f where f.id=:id");
        query.setLong("id", id);
        return (query.uniqueResult() != null);
    }

    public void update(Food food) {
        currentSession().update(food);
    }

    public List<Food> findForCustomer(Long customerId) {
        Query query = currentSession().createQuery("from Food f where f.customerId=:customerId");
        query.setLong("customerId", customerId);
        return query.list();
    }
}