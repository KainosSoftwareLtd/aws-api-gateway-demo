package com.kainos.apigateways.aws.demo.customer;

import com.kainos.apigateways.aws.demo.customer.db.CustomerDao;
import com.kainos.apigateways.aws.demo.customer.entities.Customer;
import com.kainos.apigateways.aws.demo.customer.resources.CustomerResource;
import io.dropwizard.Application;
import io.dropwizard.configuration.EnvironmentVariableSubstitutor;
import io.dropwizard.configuration.SubstitutingSourceProvider;
import io.dropwizard.db.DataSourceFactory;
import io.dropwizard.hibernate.HibernateBundle;
import io.dropwizard.setup.Bootstrap;
import io.dropwizard.setup.Environment;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CustomerApplication extends Application<AppConfiguration> {

    private final HibernateBundle<AppConfiguration> hibernate = new HibernateBundle<AppConfiguration>(Customer.class) {
        public DataSourceFactory getDataSourceFactory(AppConfiguration configuration) {
            return configuration.getDataSourceFactory();
        }
    };

    public static void main(String[] args) throws Exception {
        new CustomerApplication().run(args);
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
                        new EnvironmentVariableSubstitutor()));
    }

    @Override
    public void run(AppConfiguration configuration, Environment environment) {
        final CustomerDao dao = new CustomerDao(hibernate.getSessionFactory());
        final Logger logger = LoggerFactory.getLogger("com.kainos.apigateways.aws.demo.customer");
        environment.jersey().register(new CustomerResource(dao, logger));
    }
}