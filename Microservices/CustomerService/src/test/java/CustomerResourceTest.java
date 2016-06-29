import com.kainos.apigateways.aws.demo.customer.db.CustomerDao;
import com.kainos.apigateways.aws.demo.customer.entities.Customer;
import com.kainos.apigateways.aws.demo.customer.resources.CustomerResource;
import io.dropwizard.testing.junit.ResourceTestRule;
import org.junit.After;
import org.junit.Before;
import org.junit.ClassRule;
import org.junit.Test;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

/**
 * Created by adrianz on 29/06/16.
 */
public class CustomerResourceTest {

    private static final CustomerDao dao = mock(CustomerDao.class);

    @ClassRule
    public static final ResourceTestRule resources = ResourceTestRule.builder()
            .addResource(new CustomerResource(dao))
            .build();

    private final Customer customer = new Customer("Adrian");

    @Before
    public void setup(){
        customer.setId(Long.valueOf(1));
        when(dao.findById(Long.valueOf(eq(1)))).thenReturn(customer);
    }

    @After
    public void tearDown() {
        reset(dao);
    }

    @Test
    public void tetstGetCustomer() {
        Customer getCustomer = resources.client().target("/customer/1").request().get(Customer.class);
        System.out.println(getCustomer);
        assertThat(getCustomer).isEqualTo(customer);
//        assertThat(resources.client().target("/customer").queryParam("id", 1).request().get(Customer.class))
//                .isEqualTo(customer);
        verify(dao).findById(Long.valueOf(1));
    }

}
