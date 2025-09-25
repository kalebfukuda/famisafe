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
    assetpath: String
  }

  connect() {
    this.initMap();
    document.addEventListener("location:changed", (event) => {
      const { latitude, longitude } = event.detail;
      this.updateMarker(latitude, longitude, `contact_${this.useridValue}`);
    });
  }

  initMap() {
    const lat = this.latitudeValue || 0;
    const lng = this.longitudeValue || 0;
    let markerList = null;
    const hazardList = null;
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
    this.getHazardData().then((hazards) => {
      markerList = markerList.concat(hazards);

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
            .bindPopup(`<b>${element.name}</b><br><p style="font-size:0.5rem">${element.updated.toLocaleString()}</p>`).openPopup()
            .addTo(this.map);
          this.marker._leaflet_id = element.id;
        }
      });
    });




    setTimeout(() => this.map.invalidateSize(), 500);
  }

  updateMarker(latitude, longitude, findMarker) {
    const newLatLng = L.latLng(latitude, longitude);

    let foundMarker = this.searchMarker(findMarker);
    console.log(foundMarker);

    // If there are no marker
    if(foundMarker === undefined) {
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



  searchMarker(findMarker) {
    const allMarkers = this.getAllMarkers();
    return allMarkers.find(marker => marker._leaflet_id === findMarker);
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

  centerView(event) {
    let foundMarker = this.searchMarker(event.params.id);

    if(foundMarker) {
      this.map.setView(foundMarker._latlng, 16);
    }
  }

  async getHazardData() {
    try {
      const res = await fetch("https://api.p2pquake.net/v2/jma/quake");
      const data = await res.json();

      const hazardList = data.map(element => ({
        id: element.id,
        latitude: element.earthquake.hypocenter?.latitude ?? null,
        longitude: element.earthquake.hypocenter?.longitude ?? null,
        avatar_url: this.assetpathValue,
        name: `Earthquake: ${element.earthquake.hypocenter?.name ?? "Unknown"} (M${element.earthquake.hypocenter?.magnitude ?? "?"})`,
        updated: element.time   // use `time` instead of created_at
      }));

      return hazardList;
    } catch (err) {
      console.error(err);
      alert("An error occurred while getting earthquake info.");
      return [];
    }
  }
}
