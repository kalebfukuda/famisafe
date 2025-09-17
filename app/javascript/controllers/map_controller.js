import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    latitude: Number,
    longitude: Number
  }

  connect() {
    this.initMap();

    document.addEventListener("location:changed", (event) => {
      console.log("entrei");

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

    this.marker = L.marker([lat, lng]).addTo(this.map);

    setTimeout(() => this.map.invalidateSize(), 500);
  }

  updateMarker(latitude, longitude) {
    const newLatLng = L.latLng(latitude, longitude);
    this.marker.setLatLng(newLatLng);
    this.map.setView(newLatLng, this.map.getZoom());
    this.map.invalidateSize();
  }
}
