import com.kainos.apigateways.aws.demo.api.Customer.CustomerResponse;
import com.kainos.apigateways.aws.demo.food.clients.CustomerClient;
import com.kainos.apigateways.aws.demo.food.db.FoodDao;
import com.kainos.apigateways.aws.demo.food.entities.Food;
import com.kainos.apigateways.aws.demo.food.resources.FoodResource;
import io.dropwizard.jersey.params.LongParam;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import javax.ws.rs.BadRequestException;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.Matchers.any;
import static org.mockito.Mockito.*;

public class FoodResourceTest {

    private FoodResource resource;
    private CustomerClient client;
    private FoodDao dao;

    @Before
    public void setUp() {
        dao = mock(FoodDao.class);
        client = mock(CustomerClient.class);
        resource = new FoodResource(dao, client);
    }

    @After
    public void tearDown() {
        resource = null;
        client = null;
        dao = null;
    }

    @Test
    public void findThrowsBadRequestExceptionIfFoodNotFound() {
        LongParam nonExistentId = new LongParam("1");

        assertThatThrownBy(() -> {
            resource.find(nonExistentId);
        }).isInstanceOf(BadRequestException.class);
    }

    @Test
    public void deleteThrowsBadRequestExceptionIfFoodNotFound() {
        LongParam nonExistentId = new LongParam("1");

        assertThatThrownBy(() -> {
            resource.delete(nonExistentId);
        }).isInstanceOf(BadRequestException.class);
    }

    @Test
    public void updateThrowsBadRequestExceptionIfFoodNotFound() {
        LongParam nonExistentId = new LongParam("1");
        Food food = mock(Food.class);

        assertThatThrownBy(() -> {
            resource.update(nonExistentId, food);
        }).isInstanceOf(BadRequestException.class);
    }

    @Test
    public void createCallsDaoOnce() {
        Food food = mock(Food.class);
        resource.create(food);
        verify(dao, times(1)).create(food);
    }

    @Test
    public void updateCallsDaoOnce() {
        Food food = new Food((long) 1, "Name", 0.1, 999);
        when(dao.findById((long) 1)).thenReturn(food);

        //pretend that Food with id=1 exists
        when(dao.exists(1)).thenReturn(true);

        resource.update(new LongParam("1"), food);
        verify(dao, times(1)).update(food);
    }

    @Test
    public void deleteCallsDaoOnce() {
        //pretend that Food with id=1 exists
        when(dao.exists(1)).thenReturn(true);
        resource.delete(new LongParam("1"));
        verify(dao, times(1)).delete((long) 1);
    }

    @Test
    public void findCallsDaoOnce() {
        //pretend that Food with id=1 exists
        when(dao.exists(1)).thenReturn(true);
        resource.find(new LongParam("1"));
        verify(dao, times(1)).findById((long) 1);
    }

    @Test
    public void buyCallsFindAndUpdateOnce() {
        Food testFood = new Food(1l, "food", 2., 1);
        Food foodWithOwner = new Food();
        foodWithOwner.setCustomerId(3l);

        //pretend that Food with id=1 exists
        when(dao.exists(1)).thenReturn(true);
        when(dao.findById(1l)).thenReturn(testFood);
        when(client.getCustomer(3l)).thenReturn(new CustomerResponse());
        resource.buy(new LongParam("1"), foodWithOwner);

        verify(dao, times(1)).findById((long) 1);
        verify(dao, times(1)).update(any(Food.class));
        assertThat(testFood.getCustomerId()).isEqualTo(3l);
    }

    @Test
    public void buyFailsIfCustomerIdIsNull() {
        //pretend that Food with id=1 exists
        when(dao.exists(1)).thenReturn(true);
        boolean response = resource.buy(new LongParam("1"), null);

        assertThat(response).isFalse();
    }

    @Test
    public void buySucceedsIfFoodExistsAndCustomerIsNotNull() {
        Food testFood = new Food(2l, "food", 2., 1);
        testFood.setCustomerId(1l);

        //pretend that Food with id=1 exists
        when(dao.exists(1)).thenReturn(true);
        when(dao.findById(1l)).thenReturn(testFood);
        when(client.getCustomer(1l)).thenReturn(new CustomerResponse());
        boolean response = resource.buy(new LongParam("1"), testFood);

        assertThat(response).isTrue();
    }
}
