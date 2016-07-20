<#-- @ftlvariable name="" type="com.github.scratch.dropwizard.views.HomePageView" -->
<html>
<head>
    <title>Homepage</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <script src="/assets/js/jquery-2.2.3.min.js"></script>
    <script src="/assets/js/bootstrap.min.js"></script>
    <link href="/assets/css/bootstrap.min.css" rel="stylesheet"/>
</head>

<body>
<div id="locationField">
    <input id="billing-autocomplete" placeholder="Enter your billing address" onFocus="geolocate(this.id)" type="text"></input>
</div>

<table id="address">
    <tr>
        <td class="label-default" for="billing-street_number">Street address</td>
        <td><input class="field" id="billing-street_number" disabled="true"></input></td>
        <td colspan="2"><input class="field" id="billing-route" disabled="true"></input></td>
    </tr>
    <tr>
        <td class="label-default" for="billing-locality">City</td>
        <td colspan="3"><input class="field" id="billing-locality" disabled="true"></input></td>
    </tr>
    <tr>
        <td class="label-default" for="billing-administrative_area_level_1">State</td>
        <td><input class="field" id="billing-administrative_area_level_1" disabled="true"></input></td>
        <td class="label-default" for="billing-postal_code">Zip code</td>
        <td><input class="field" id="billing-postal_code" disabled="true"></input></td>
    </tr>
    <tr>
        <td class="label-default" for="billing-country">Country</td>
        <td colspan="3"><input class="field" id="billing-country" disabled="true"></input></td>
    </tr>
</table>

<br/>

<div id="locationField">
    <input id="shipping-autocomplete" placeholder="Enter your shipping address" onFocus="geolocate(this.id)" type="text"></input>
</div>

<table id="address">
    <tr>
        <td class="label-default" for="shipping-street_number">Street address</td>
        <td><input class="field" id="shipping-street_number" disabled="true"></input></td>
        <td colspan="2"><input class="field" id="shipping-route" disabled="true"></input></td>
    </tr>
    <tr>
        <td class="label-default" for="shipping-locality">City</td>
        <td colspan="3"><input class="field" id="shipping-locality" disabled="true"></input></td>
    </tr>
    <tr>
        <td class="label-default" for="shipping-administrative_area_level_1">State</td>
        <td><input class="field" id="shipping-administrative_area_level_1" disabled="true"></input></td>
        <td class="label-default" for="shipping-postal_code">Zip code</td>
        <td><input class="field" id="shipping-postal_code" disabled="true"></input></td>
    </tr>
    <tr>
        <td class="label-default" for="shipping-country">Country</td>
        <td colspan="3"><input class="field" id="shipping-country" disabled="true"></input></td>
    </tr>
</table>

<script type="text/javascript">
    // This example displays an address form, using the autocomplete feature
    // of the Google Places API to help users fill in the information.

    // This example requires the Places library. Include the libraries=places
    // parameter when you first load the API. For example:
    // <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&libraries=places">

    var autocompletes = {};

    var componentForm = {
        street_number: 'short_name',
        route: 'long_name',
        locality: 'long_name',
        administrative_area_level_1: 'short_name',
        country: 'long_name',
        postal_code: 'short_name'
    };

    autocompletes["billing"] = {};
    autocompletes["shipping"] = {};

    function initAutocomplete() {
        for (var key in autocompletes) {
            // Create the autocomplete object, restricting the search to geographical
            // location types.
            autocompletes[key]["autocomplete"] = new google.maps.places.Autocomplete(
                    /** @type {!HTMLInputElement} */
                    (document.getElementById(key+'-autocomplete')),
                    {types: ['geocode']});

            // When the user selects an address from the dropdown, populate the address
            // fields in the form.

            google.maps.event.addListener(autocompletes[key]["autocomplete"], 'place_changed', function() {
                fillInAddress("billing", autocompletes["billing"]["autocomplete"]);
                fillInAddress("shipping", autocompletes["shipping"]["autocomplete"]);
            });
        }
    }

    function fillInAddress(key) {
        // Get the place details from the autocomplete object.
        var place = autocompletes[key]["autocomplete"].getPlace();

        for (var component in componentForm) {
            document.getElementById(key+"-"+component).value = "";
            document.getElementById(key+"-"+component).disabled = false;
        }

        // Get each component of the address from the place details
        // and fill the corresponding field on the form.
        for (var i = 0; i < place.address_components.length; i++) {
            var addressType = place.address_components[i].types[0];
            if (componentForm[addressType]) {
                var val = place.address_components[i][componentForm[addressType]];
                document.getElementById(key+"-"+addressType).value = val;
                if (addressType.localeCompare('street_number') == 0) {
                    console.log('street_number: ' + val);
                } else if (addressType.localeCompare('route') == 0) {
                    console.log('route: ' + val);
                } else if (addressType.localeCompare('locality') == 0) {
                    console.log('locality: ' + val);
                } else if (addressType.localeCompare('administrative_area_level_1') == 0) {
                    console.log('administrative_area_level_1: ' + val);
                } else if (addressType.localeCompare('country') == 0) {
                    console.log('country: ' + val);
                } else if (addressType.localeCompare('postal_code') == 0) {
                    console.log('postal_code: ' + val);
                }
            }
        }
    }

    // Bias the autocomplete object to the user's geographical location,
    // as supplied by the browser's 'navigator.geolocation' object.
    function geolocate(key) {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function(position) {
                var geolocation = {
                    lat: position.coords.latitude,
                    lng: position.coords.longitude
                };
                var circle = new google.maps.Circle({
                    center: geolocation,
                    radius: position.coords.accuracy
                });
                autocompletes[key]["autocomplete"].setBounds(circle.getBounds());
            });
        }
    }
</script>
<script src="https://maps.googleapis.com/maps/api/js?key=${getGoogleAPIKey()}&libraries=places&callback=initAutocomplete"
        defer></script>
</body>
</html>
