import com.kainos.apigateways.aws.demo.customer.db.CustomerDao;
import com.kainos.apigateways.aws.demo.customer.entities.Customer;
import com.kainos.apigateways.aws.demo.customer.resources.CustomerResource;
import io.dropwizard.jersey.params.LongParam;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import javax.ws.rs.BadRequestException;

import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.Matchers.any;
import static org.mockito.Mockito.*;

public class CustomerResourceTest {

    private CustomerResource resource;
    private CustomerDao dao;

    @Before
    public void setUp() {
        dao = mock(CustomerDao.class);
        resource = new CustomerResource(dao);
    }

    @After
    public void tearDown() {
        resource = null;
        dao = null;
    }

    @Test
    public void findThrowsBadRequestExceptionIfCustomerNotFound() {
        LongParam nonExistentId = new LongParam("1");

        assertThatThrownBy(() -> {
            resource.find(nonExistentId);
        }).isInstanceOf(BadRequestException.class);
    }

    @Test
    public void deleteThrowsBadRequestExceptionIfCustomerNotFound() {
        LongParam nonExistentId = new LongParam("1");

        assertThatThrownBy(() -> {
            resource.delete(nonExistentId);
        }).isInstanceOf(BadRequestException.class);
    }

    @Test
    public void updateThrowsBadRequestExceptionIfCustomerNotFound() {
        LongParam nonExistentId = new LongParam("1");
        Customer customer = mock(Customer.class);

        assertThatThrownBy(() -> {
            resource.update(nonExistentId, customer);
        }).isInstanceOf(BadRequestException.class);
    }

    @Test
    public void createCallsDaoOnce() {
        resource.create(new Customer());
        verify(dao, times(1)).create(any(Customer.class));
    }

    @Test
    public void updateCallsDaoOnce() {
        Customer customer = new Customer("Name");
        when(dao.findById((long) 1)).thenReturn(customer);

        //pretend that Customer with id=1 exists
        when(dao.exists(1)).thenReturn(true);

        resource.update(new LongParam("1"), customer);
        verify(dao, times(1)).update(customer);
    }

    @Test
    public void deleteCallsDaoOnce() {
        //pretend that Customer with id=1 exists
        when(dao.exists(1)).thenReturn(true);
        resource.delete(new LongParam("1"));
        verify(dao, times(1)).delete((long) 1);
    }

    @Test
    public void findCallsDaoOnce() {
        //pretend that Customer with id=1 exists
        when(dao.exists(1)).thenReturn(true);
        when(dao.findById(1l)).thenReturn(new Customer());
        resource.find(new LongParam("1"));
        verify(dao, times(1)).findById((long) 1);
    }
}
