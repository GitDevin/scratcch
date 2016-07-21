<#-- @ftlvariable name="" type="com.github.scratch.dropwizard.views.HomePageView" -->
<html>
<head>
    <title>Homepage</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <script src="/assets/js/jquery-2.2.3.min.js"></script>
    <script src="/assets/js/bootstrap.min.js"></script>
    <script src="https://maps.googleapis.com/maps/api/js?sensor=false&key=${getGoogleAPIKey()}&libraries=places">
    </script>
    <link href="/assets/css/bootstrap.min.css" rel="stylesheet"/>
</head>

<body>
<div id="locationField">
    <input class="autocomplete" id="billing" placeholder="Enter your billing address" type="text"></input>
</div>

<table id="billing-address">
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
    <input class="autocomplete" id="shipping" placeholder="Enter your shipping address" type="text"></input>
</div>

<table id="shipping-address">
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
    var componentForm = {
        street_number: 'short_name',
        route: 'long_name',
        locality: 'long_name',
        administrative_area_level_1: 'short_name',
        country: 'long_name',
        postal_code: 'short_name'
    };

    function initialize() {
        var acInputs = document.getElementsByClassName("autocomplete");

        for (var i = 0; i < acInputs.length; i++) {
            var autocomplete = new google.maps.places.Autocomplete(acInputs[i]);
            autocomplete.inputId = acInputs[i].id;

            google.maps.event.addListener(autocomplete, 'place_changed', function () {
                console.log('You used input with id ' + this.inputId);
                var place = this.getPlace();

                for (var component in componentForm) {
                    document.getElementById(this.inputId+"-"+component).value = "";
                    document.getElementById(this.inputId+"-"+component).disabled = false;
                }

                // Get each component of the address from the place details
                // and fill the corresponding field on the form.
                for (var i = 0; i < place.address_components.length; i++) {
                    var addressType = place.address_components[i].types[0];
                    if (componentForm[addressType]) {
                        var val = place.address_components[i][componentForm[addressType]];
                        document.getElementById(this.inputId+"-"+addressType).value = val;
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
            });
        }
    }

    initialize();
</script>

</body>
</html>
