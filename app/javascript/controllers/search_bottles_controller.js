import { Controller } from '@hotwired/stimulus'

// Connects to data-controller="search-bottles"
export default class extends Controller {
  static targets = ['form', 'search', 'minPrice', 'maxPrice', 'list']

  update() {
    const url = `${this.formTarget.action}?search=${this.searchTarget.value}&min_price=${this.minPriceTarget.value}&max_price=${this.maxPriceTarget.value}&commit=Search`
    fetch(url, {headers: {'Accept': 'text/plain'}})
    .then(response => response.text())
    .then((data) => {
      this.listTarget.outerHTML = data
    })
  }

  reset_search(event) {
    event.preventDefault()

    this.searchTarget.value = ''
    this.minPriceTarget.value = ''
    this.maxPriceTarget.value = ''

    this.update()
  }
}
