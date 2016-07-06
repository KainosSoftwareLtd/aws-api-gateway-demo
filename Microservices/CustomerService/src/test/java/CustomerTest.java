import com.fasterxml.jackson.databind.ObjectMapper;
import com.kainos.apigateways.aws.demo.customer.entities.Customer;
import io.dropwizard.jackson.Jackson;
import org.junit.Test;

import java.io.IOException;

import static io.dropwizard.testing.FixtureHelpers.fixture;
import static org.assertj.core.api.Assertions.assertThat;


public class CustomerTest {

    private static final ObjectMapper MAPPER = Jackson.newObjectMapper();

    @Test
    public void serializesToJSON() throws IOException {

        final Customer customer = new Customer("Adrian");

        final String expectedCustomer = MAPPER.writeValueAsString(
                MAPPER.readValue(fixture("fixtures/customer.json"), Customer.class));
        final String writtenCustomer = MAPPER.writeValueAsString(customer);

        assertThat(writtenCustomer).isEqualTo(expectedCustomer);
    }

    @Test
    public void deserializesFromJSON() throws IOException {

        final Customer customer = new Customer("Adrian");

        Customer deserializedCustomer = MAPPER.readValue(fixture("fixtures/customer.json"), Customer.class);

        assertThat(deserializedCustomer).isEqualTo(customer);
    }
}
