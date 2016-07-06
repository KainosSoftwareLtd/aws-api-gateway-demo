package com.kainos.apigateways.aws.demo.food;

import com.kainos.apigateways.aws.demo.food.db.FoodDao;
import com.kainos.apigateways.aws.demo.food.entities.Food;
import com.kainos.apigateways.aws.demo.food.resources.FoodResource;
import io.dropwizard.Application;
import io.dropwizard.configuration.EnvironmentVariableSubstitutor;
import io.dropwizard.configuration.SubstitutingSourceProvider;
import io.dropwizard.db.DataSourceFactory;
import io.dropwizard.hibernate.HibernateBundle;
import io.dropwizard.setup.Bootstrap;
import io.dropwizard.setup.Environment;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class FoodApplication extends Application<AppConfiguration> {

    private final HibernateBundle<AppConfiguration> hibernate = new HibernateBundle<AppConfiguration>(Food.class) {
        public DataSourceFactory getDataSourceFactory(AppConfiguration configuration) {
            return configuration.getDataSourceFactory();
        }
    };

    public static void main(String[] args) throws Exception {
        new FoodApplication().run(args);
    }

    @Override
    public String getName() {
        return "config";
    }

    @Override
    public void initialize(Bootstrap<AppConfiguration> bootstrap) {
        bootstrap.addBundle(hibernate);

        // Enable variable substitution with environment variables
        bootstrap.setConfigurationSourceProvider(
                new SubstitutingSourceProvider(bootstrap.getConfigurationSourceProvider(),
                        new EnvironmentVariableSubstitutor()
                )
        );

    }

    @Override
    public void run(AppConfiguration configuration, Environment environment) {
        final FoodDao dao = new FoodDao(hibernate.getSessionFactory());
        final Logger logger = LoggerFactory.getLogger("com.kainos.apigateways.aws.demo.food");
        environment.jersey().register(new FoodResource(dao, logger));
    }
}
