import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="map"
export default class extends Controller {
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
      this.updateMarker(latitude, longitude);
    });
  }

  initMap() {
    const lat = this.latitudeValue || 0;
    const lng = this.longitudeValue || 0;

    this.map = L.map(this.element).setView([lat, lng], 12);

    L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
      attribution: "&copy; OpenStreetMap contributors",
      maxZoom: 19
    }).addTo(this.map);

    //Shows all locations for all places and contacts
    if(this.viewtypeValue === "all") {
      this.contactsValue.forEach(element => {
        if (element.latitude !== null) {
          const contactLat = element.latitude;
          const contactLng = element.longitude;

          if (element.avatar !== null) {
            var customIcon = L.icon({
              iconUrl: element.avatar_url,
              iconSize:     [35, 35],
              iconAnchor:   [22, 22], // point of the icon which will correspond to marker's location
              popupAnchor:  [-3, -76] // point from which the popup should open relative to the iconAnchor
            });
          }

          this.marker = L.marker([contactLat, contactLng], { icon:customIcon }).addTo(this.map);
          this.marker._leaflet_id = element.id;
          console.log(this.marker._leaflet_id);

        }
      });
      // Show only addresses for contacts and other places
    } else if(this.viewtypeValue === "only-address") {
      this.addressesValue.forEach(element => {
        if (element.latitude !== null) {
          const contactLat = element.latitude;
          const contactLng = element.longitude;

          if (element.avatar !== null) {
            var customIcon = L.icon({
              iconUrl: element.avatar_url,
              iconSize:     [35, 35],
              iconAnchor:   [22, 22], // point of the icon which will correspond to marker's location
              popupAnchor:  [-3, -76] // point from which the popup should open relative to the iconAnchor
            });
          }

          this.marker = L.marker([contactLat, contactLng], { icon:customIcon }).addTo(this.map);
          this.marker._leaflet_id = element.id;
          console.log(this.marker._leaflet_id);

        }
      });
    }


    setTimeout(() => this.map.invalidateSize(), 500);
  }

  updateMarker(latitude, longitude) {
    const newLatLng = L.latLng(latitude, longitude);
    const allMarkers = this.getAllMarkers();


    allMarkers.forEach((element) => {
      if (element._leaflet_id === this.useridValue) {
        element.setLatLng(newLatLng);
      }
    })

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
}
