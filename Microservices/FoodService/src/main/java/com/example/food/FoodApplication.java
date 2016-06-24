package com.example.food;

import com.example.food.api.Food;
import com.example.food.db.FoodDao;
import com.example.food.resources.FoodResource;
import io.dropwizard.Application;
import io.dropwizard.configuration.EnvironmentVariableSubstitutor;
import io.dropwizard.configuration.SubstitutingSourceProvider;
import io.dropwizard.db.DataSourceFactory;
import io.dropwizard.hibernate.HibernateBundle;
import io.dropwizard.migrations.MigrationsBundle;
import io.dropwizard.setup.Bootstrap;
import io.dropwizard.setup.Environment;

/**
 * Created by adrianz on 20/06/16.
 */
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

        bootstrap.addBundle(new MigrationsBundle<AppConfiguration>() {
            public DataSourceFactory getDataSourceFactory(AppConfiguration configuration) {
                return configuration.getDataSourceFactory();
            }
        });

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
        environment.jersey().register(new FoodResource(dao));
    }

}
