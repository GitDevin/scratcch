package com.github.scratch.dropwizard.views

import io.dropwizard.views.View

/**
 * Created by kun on 12/07/16.
 */
class HomePageView extends View {
    String googleAPIKey

    public HomePageView(String googleAPIKey) {
        super("homepage.ftl")
        this.googleAPIKey = googleAPIKey
    }
}
