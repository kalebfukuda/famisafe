import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="map"
export default class extends Controller {
  static targets= ["createaddress", "map"]
  static values = {
    latitude: Number,
    longitude: Number,
    contacts: Array,
    addresses: Array,
    userid: Number,
    viewtype: String,
  }

  connect() {
    this.initMap();
    document.addEventListener("location:changed", (event) => {
      const { latitude, longitude } = event.detail;
      this.updateMarker(latitude, longitude, this.useridValue);
    });
  }

  initMap() {
    const lat = this.latitudeValue || 0;
    const lng = this.longitudeValue || 0;
    let markerList = null;
    this.map = L.map(this.mapTarget).setView([lat, lng], 12);

    L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
      attribution: "&copy; OpenStreetMap contributors",
      maxZoom: 19
    }).addTo(this.map);

    //Add touch event to map
    this.map.on('click', (e) => {
        const lat = e.latlng.lat;
        const lng = e.latlng.lng;

        this.updateMarker(lat, lng, "custom");
        this.getOSMData(lat, lng);
    });

    if(this.viewtypeValue === "all") {
      markerList = this.contactsValue.concat(this.addressesValue);
    } else if (this.viewtypeValue === "only-address") {
      markerList = this.addressesValue;
    }

    //Shows all locations for all places and contacts
    if(markerList !== null) {
      markerList.forEach(element => {
        if (element.latitude !== null) {
          const contactLat = element.latitude;
          const contactLng = element.longitude;

          if (element.avatar !== null) {
            var customIcon = L.icon({
              iconUrl: element.avatar_url,
              iconSize:     [35, 35],
              iconAnchor:   [22, 22], // point of the icon which will correspond to marker's location
              popupAnchor:  [-3, -10] // point from which the popup should open relative to the iconAnchor
            });
          }

          this.marker = L.marker([contactLat, contactLng], { icon:customIcon })
            .bindPopup(`<b>${element.name}</b><br>`).openPopup()
            .addTo(this.map);
          this.marker._leaflet_id = element.id;
          console.log(this.marker._leaflet_id);

        }
      });
    }
    setTimeout(() => this.map.invalidateSize(), 500);
  }

  updateMarker(latitude, longitude, findMarker) {
    const newLatLng = L.latLng(latitude, longitude);
    const allMarkers = this.getAllMarkers();
    let foundMarker = null;

    allMarkers.forEach((element) => {
      if (element._leaflet_id === findMarker) {
        foundMarker = element;
      }
    })

    // If there are no marker
    if(foundMarker === null) {
      foundMarker = L.marker(newLatLng).addTo(this.map);
      foundMarker._leaflet_id = "custom";
    } else {
      foundMarker.setLatLng(newLatLng);
    }

    this.map.setView(newLatLng, this.map.getZoom());
    this.map.invalidateSize();
  }

  getAllMarkers() {
    let allMarkers = [];

    this.map.eachLayer(layer => {
      if (layer instanceof L.Marker) {
        allMarkers.push(layer);
      }
    });

    return allMarkers
  }

  getOSMData(lat, lng) {
    fetch(`/addresses/reverse_geocode?lat=${lat}&lng=${lng}`)
    .then((res) => res.json())
    .then((data) => {
      this.createaddressTarget.classList.remove("d-none");
      console.log(data);

      //Add data from click to simple_form
      if(data) {
        const form = this.createaddressTarget.querySelector("form");
        form.querySelector("[name='address[postal_code]']").value = data.address.postcode;
        form.querySelector("[name='address[prefecture]']").value = data.address.suburb;
        form.querySelector("[name='address[city]']").value = data.address.city;
        form.querySelector("[name='address[block]']").value = data.address.neighbourhood;
        form.querySelector("[name='address[latitude]']").value = lat;
        form.querySelector("[name='address[longitude]']").value = lng;
      }
    })
    .catch((err) => {
      console.error(err);
      alert("An error occurred while updating location.");
    });
  }
}
