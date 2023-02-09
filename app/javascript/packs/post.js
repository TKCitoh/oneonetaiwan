  let map
  let geocoder

  function initMap(){
    geocoder = new google.maps.Geocoder()
    if(!navigator.geolocation) {
      alert('Geolocation APIに対応していません');
      return false;
    }

    navigator.geolocation.getCurrentPosition(function(position) {
      latLng = new google.maps.LatLng(25.04804725973179, 121.51702880859375);

      map = new google.maps.Map(document.getElementById('map'), {
        center: latLng,
        zoom: 12,
      });

      marker = new google.maps.Marker({
        position:  latLng,
        map: map
      });

      google.maps.event.addListener(map, 'click', clickEvent)

    }, function() {
        alert('位置情報取得に失敗しました');
      });
  }

  function clickEvent(event) {
    marker.setMap(null);
    marker = new google.maps.Marker({
      position: event.latLng,
      map: map
    });
    $('#post_latitude').val(event.latLng.lat());
    $('#post_longitude').val(event.latLng.lng());
  }

  function codeAddress(){
    let inputAddress = document.getElementById('address').value;

    geocoder.geocode( { 'address': inputAddress}, function(results, status) {
      if (status == 'OK') {
        map.setCenter(results[0].geometry.location);
      } else {
          alert('該当する結果がありませんでした：' + status);
      }
    });
  }
