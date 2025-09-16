document.addEventListener("turbo:load", function() {
  var map = L.map("map").setView([35.6895, 139.6917], 12);

  L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
    attribution: "&copy; OpenStreetMap contributors",
    maxZoom: 19
  }).addTo(map);

  L.marker([35.6895, 139.6917]).addTo(map)
    .bindPopup("Estamos em Tóquio!")
    .openPopup();

  setTimeout(() => {
    map.invalidateSize();
  }, 500);
});
