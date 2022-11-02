import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="map"
export default class extends Controller {
  static values = { apiKey: String }
  connect() {
    mapboxgl.accessToken = this.apiKeyValue
    this.map = new mapboxgl.Map({
      container: this.element,
      style: 'mapbox://styles/mapbox/streets-v11', // style URL
      //center: [-74.5, 40], // starting position [lng, lat]
      //zoom: 9, // starting zoom
      //projection: 'globe' // display the map as a 3D globe
    });

    // map.on('style.load', () => {
    //   map.setFog({}); // Set the default atmosphere style
    // });

    this.#addMakersToMap()
  }
  #addMakersToMap() {
    new mapboxgl.Marker()
      .setLngLat([-65.017, -16.457])
      .addTo(this.map);
  }
}


// import { Controller } from "@hotwired/stimulus"

// export default class extends Controller {
//   static values = {
//     apiKey: String,
//     markers: Array
//   }

//   connect() {
//     mapboxgl.accessToken = this.apiKeyValue

//     this.map = new mapboxgl.Map({
//       container: this.element,
//       style: "mapbox://styles/mapbox/streets-v10"
//     })
//   }
// }
