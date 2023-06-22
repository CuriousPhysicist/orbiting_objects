import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="satellite"
export default class extends Controller {
  static targets = ["satelliteNumber"]

  connect() {
    console.log('connected')
  }

  refereshPosition() {
    console.log('button pressed')
    location.reload()
  }

  async getTargetSatellites() {
    const token = document.getElementsByName('csrf-token').item(0).content
    const satelliteNumber = this.satelliteNumberTarget.value || 20

    const response = await fetch(`https://tle.ivanstanojevic.me/api/tle/?page-size=${satelliteNumber}`)
    const jsonResponse = await response.json()
    const targetSatellites = jsonResponse["member"]
    const candidateSatellites = JSON.stringify(targetSatellites).replace(/satelliteId/g, 'satellite_id')
    const options = {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': `${token}`
      },
      body: candidateSatellites
    }

    const temp = await fetch('/satellite', options)
    location.reload()
  }
}
