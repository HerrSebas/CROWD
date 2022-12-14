import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue
    this.map = new mapboxgl.Map({
      container: this.element,
      style: 'mapbox://styles/mapbox/light-v10', // style URL
      //center: [-74.5, 40], // starting position [lng, lat]
      //zoom: 9, // starting zoom
      //projection: 'globe' // display the map as a 3D globe
    });

    // map.on('style.load', () => {
    //   map.setFog({}); // Set the default atmosphere style
    // });

    this.#addMakersToMap()
    this.#fitMapToMarkers()
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach((marker) => {
      bounds.extend([marker.lng, marker.lat])
    })
    this.map.fitBounds(bounds, { padding: 50 })
  }

  #addMakersToMap() {
    this.markersValue.forEach((marker) => {
      const customMarker = document.createElement('div')
      customMarker.style.height = "30px"
      customMarker.style.width = "20px"
      customMarker.style.backgroundSize = "contain"
      customMarker.style.backgroundImage = `url('${marker.image_url}')`

      const popup = new mapboxgl.Popup().setHTML(marker.info_window)
      new mapboxgl.Marker({ element: customMarker })
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(this.map);
    })
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
