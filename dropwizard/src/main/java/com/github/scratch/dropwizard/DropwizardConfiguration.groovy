package com.github.scratch.dropwizard

import io.dropwizard.Configuration

import javax.validation.constraints.NotNull

/**
 * Created by kun on 12/07/16.
 */
class DropwizardConfiguration extends Configuration {
    @NotNull
    private Map<String, Map<String, String>> viewRendererConfiguration = new HashMap<>();

    Map<String, Map<String, String>> getViewRendererConfiguration() {
        return this.viewRendererConfiguration
    }

    @NotNull
    String googleAPIKey
}
