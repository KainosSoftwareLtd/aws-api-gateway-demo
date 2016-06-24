package com.example.food.db;

import com.example.food.api.Food;
import io.dropwizard.hibernate.AbstractDAO;
import org.hibernate.Query;
import org.hibernate.SessionFactory;

/**
 * Created by adrianz on 21/06/16.
 */
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

    public void update(Long id, Food food) {

        Food updatedFood = get(id);

        if (food.getPrice() != null) {
            updatedFood.setPrice(food.getPrice());
        }
        if (food.getName() != null) {
            updatedFood.setName(food.getName());
        }
        if (food.getQuantity() != null) {
            updatedFood.setQuantity(food.getQuantity());
        }

        currentSession().update(updatedFood);
    }

}
