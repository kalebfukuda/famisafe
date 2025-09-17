import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    latitude: Number,
    longitude: Number
  }

  connect() {
    this.updateLocation();
  }

  updateLocation(){
    document.addEventListener("turbo:load", () => {
      var map = L.map("map").setView([this.latitudeValue, this.longitudeValue ], 12);

      L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
        attribution: "&copy; OpenStreetMap contributors",
        maxZoom: 19
      }).addTo(map);

      L.marker([this.latitudeValue, this.longitudeValue ]).addTo(map);


      setTimeout(() => {
        map.invalidateSize();
      }, 500);
    });
  }
}
