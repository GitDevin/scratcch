package com.github.scratch.dropwizard.resources

import com.codahale.metrics.annotation.Timed
import com.github.scratch.dropwizard.views.HomePageView

import javax.ws.rs.GET
import javax.ws.rs.Path
import javax.ws.rs.Produces
import javax.ws.rs.core.MediaType

/**
 * Created by kun on 12/07/16.
 */
@Path("/")
class HomePageViewResources {
    String googleAPIKey

    public HomePageViewResources(String googleAPIKey) {
        this.googleAPIKey = googleAPIKey
    }

    @Timed
    @GET
    @Path("/")
    @Produces(MediaType.TEXT_HTML)
    public HomePageView getHomepage() {
        return new HomePageView(this.googleAPIKey)
    }
}
