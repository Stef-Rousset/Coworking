import { totalPriceWithoutService } from '../plugins/fullCalendar';


const services = () => {

  let totalPriceWithServices;
  const serviceField = document.querySelector('.services-fields');
  if (serviceField) {
      const priceDiv = document.querySelector('.priceSummary');
      let servicesPriceArray = [];
      serviceField.addEventListener('change', event => {
        const services = document.querySelectorAll('.service');
        // confirmer la resa: recup l'element ou inserer les services
        const serviceInfo = document.querySelector('.fa-concierge-bell');

        services.forEach(function(service, index) {
            //type de service
            let serv = service.firstElementChild.lastElementChild;
            //quantité de service
            let quant = service.lastElementChild.lastElementChild;
            service.addEventListener('change', event => {
              if (document.getElementById(`${index}`) != null) {
                  document.getElementById(`${index}`).remove();
              }
              if ((serv.value != '') && (quant.value != '')) {
                  let servicePrice = 0;
                  let optionSelected = serv.options[serv.selectedIndex];
                  servicePrice = Number(optionSelected.dataset.price) * quant.value ;
                  servicesPriceArray[index] = servicePrice;
                  let text = quant.value <= 1 ? optionSelected.innerText : (optionSelected.innerText + 's')

                  serviceInfo.insertAdjacentHTML('afterend', `<span id=${index}> ${quant.value} ${text}</span>` );
                  totalPriceWithServices = totalPriceWithoutService + servicesPriceArray.reduce((acc, curV) => acc + curV, 0);
                  if (document.querySelector('.priceSummarySpan') != null){
                      document.querySelector('.priceSummarySpan').remove();
                      priceDiv.insertAdjacentHTML('afterend', `<span class="priceSummarySpan"> ${totalPriceWithServices} €</span>` );
                  }
              }
            })
        });
      })
  }
};


export { services }
