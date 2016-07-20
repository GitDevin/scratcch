package com.github.scratch.dropwizard

import com.github.scratch.dropwizard.resources.HomePageViewResources
import io.dropwizard.Application
import io.dropwizard.assets.AssetsBundle
import io.dropwizard.setup.Bootstrap
import io.dropwizard.setup.Environment
import io.dropwizard.views.ViewBundle

/**
 * Created by kun on 12/07/16.
 */
class Dropwizard  extends Application<DropwizardConfiguration> {

    public static void main(String[] args) throws Exception {
        new Dropwizard().run(args)
    }

    @Override
    void initialize(Bootstrap<DropwizardConfiguration> bootstrap) {
        super.initialize(bootstrap)
        bootstrap.addBundle(new AssetsBundle("/assets/", "/assets/"))
        bootstrap.addBundle(new ViewBundle<DropwizardConfiguration>() {
            @Override
            public Map<String, Map<String, String>> getViewConfiguration(DropwizardConfiguration config) {
                return config.getViewRendererConfiguration()
            }
        })
    }

    @Override
    void run(DropwizardConfiguration dropwizardConfiguration, Environment environment) throws Exception {
        def googleAPIKey = dropwizardConfiguration.getGoogleAPIKey()
        environment.jersey().register(new HomePageViewResources(googleAPIKey))
    }
}
