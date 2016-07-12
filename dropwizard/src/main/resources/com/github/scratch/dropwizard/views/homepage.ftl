<#-- @ftlvariable name="" type="com.github.scratch.dropwizard.views.HomePageView" -->
<html>
<head>
    <title>Homepage</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <script src="/assets/js/jquery-2.2.3.min.js"></script>
    <script src="/assets/js/bootstrap.min.js"></script>
    <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&libraries=places"></script>
    <link href="/assets/css/bootstrap.min.css" rel="stylesheet"/>
</head>

<body>
<input id="pac-input" class="controls" type="text" placeholder="Enter a location">

<label id="suburb">suburb</label>
<label id="street">street</label>
<label id="state">state</label>
<label id="postcode">postcode</label>

<script>
    $(document).ready(function () {
        autocomplete.addListener('place_changed', function () {
            var address = '';
            if (place.address_components) {
                address = [
                    (place.address_components[0] && place.address_components[0].short_name || ''),
                    (place.address_components[1] && place.address_components[1].short_name || ''),
                    (place.address_components[2] && place.address_components[2].short_name || '')
                ].join(' ');
            }

            infowindow.setContent('<div><strong>' + place.name + '</strong><br>' + address);
        });
    });
</script>
</body>
</html>
