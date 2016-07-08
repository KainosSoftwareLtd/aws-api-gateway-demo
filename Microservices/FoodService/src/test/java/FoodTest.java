import com.fasterxml.jackson.databind.ObjectMapper;
import com.kainos.apigateways.aws.demo.food.entities.Food;
import io.dropwizard.jackson.Jackson;
import org.junit.Test;

import java.io.IOException;

import static io.dropwizard.testing.FixtureHelpers.fixture;
import static org.assertj.core.api.Assertions.assertThat;

public class FoodTest {

    private static final ObjectMapper MAPPER = Jackson.newObjectMapper();

    @Test
    public void serializesToJSON() throws IOException {

        final Food food = new Food((long) 1, "banana", 0.5, 999);

        final String expectedFood = MAPPER.writeValueAsString(
                MAPPER.readValue(fixture("fixtures/food.json"), Food.class));
        final String writtenFood = MAPPER.writeValueAsString(food);

        assertThat(writtenFood).isEqualTo(expectedFood);
    }

    @Test
    public void deserializesFromJSON() throws IOException {

        final Food food = new Food((long) 1, "banana", 0.5, 999);

        Food deserializedFood = MAPPER.readValue(fixture("fixtures/food.json"), Food.class);

        assertThat(deserializedFood).isEqualTo(food);
    }
}
