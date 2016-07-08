import com.kainos.apigateways.aws.demo.food.db.FoodDao;
import com.kainos.apigateways.aws.demo.food.entities.Food;
import com.kainos.apigateways.aws.demo.food.resources.FoodResource;
import io.dropwizard.jersey.params.LongParam;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import javax.ws.rs.BadRequestException;

import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.Matchers.any;
import static org.mockito.Mockito.*;

public class FoodResourceTest {

    private FoodResource resource;
    private FoodDao dao;

    @Before
    public void setUp() {
        dao = mock(FoodDao.class);
        resource = new FoodResource(dao);
    }

    @After
    public void tearDown() {
        resource = null;
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
        resource.create((long) 1, "Name", 0.9, 999);
        verify(dao, times(1)).create(any(Food.class));
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
}
