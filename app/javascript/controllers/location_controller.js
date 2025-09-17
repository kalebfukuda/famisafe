import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="location"
export default class extends Controller {

  update(event) {
    event.preventDefault();

    if (!navigator.geolocation) {
      alert("Geolocation is not supported by your browser.");
      return;
    }

    navigator.geolocation.getCurrentPosition(
      (position) => {
        const latitude = position.coords.latitude;
        const longitude = position.coords.longitude;

        // Atualiza backend
        fetch("/user/update_location", {
          method: "PATCH",
          headers: {
            "Content-Type": "application/json",
            "X-CSRF-Token": document.querySelector("meta[name=csrf-token]").content,
          },
          body: JSON.stringify({ latitude, longitude }),
        })
        .then((res) => res.json())
        .then((data) => {
          if (data.status === "success") {
            this.dispatch("changed", { detail: { latitude, longitude }, bubbles: true });
          } else {
            alert("Error updating location: " + (data.errors || "").join(", "));
          }
        })
        .catch((err) => {
          console.error(err);
          alert("An error occurred while updating location.");
        });
      },
      (error) => {
        console.error(error);
        alert("Unable to retrieve your location.");
      }
    );
  }
}
