import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import interactionPlugin from '@fullcalendar/interaction';

var totalPriceWithoutService; // variable exportee dans le file services.js

const fullCalendar = () => {
  // recup les input de dates du form
  let formStartDate = document.querySelector('#booking_start_date');
  let formEndDate = document.querySelector('#booking_end_date');
  // recup les discounts
  const discountList = document.querySelector('.office-discounts__details');
  if (discountList) {
    var discounts = discountList.querySelectorAll('li');
  }

  if (formStartDate) {
    // recuperer le prix
    const office = document.querySelector('.office-title');
    const officePrice = (office.dataset.officePrice) * 60 * 7;
    // confirmer la resa
      //recup l'element ou inserer les dates
      const debut = document.querySelector('.debut');
      // recup l'element ou inserer le prix
      const priceDiv = document.querySelector('.priceSummary');
    // calendrier
    const calendarEl = document.querySelector('.calendar');

    let calendar = new Calendar(calendarEl, {
      plugins: [ dayGridPlugin, interactionPlugin ],
      initialView: 'dayGridMonth',
      selectable: true,
      headerToolbar: {
        left: 'prev,next,today',
        center: 'title',
        right: 'dayGridMonth'
      },
      select: function(info) {
        // passer les dates de resa au form
        formStartDate.value = info.start;
        let intermediateDate = new Date (info.end.setDate(info.end.getDate() - 1 ));
        formEndDate.value = intermediateDate;
        // ajouter 2h pour comparer avec les dates de discount qui commencent à 02:00:00 et pas 00:00:00
        let endDate = new Date (intermediateDate.setHours(intermediateDate.getHours() + 2));
        let startDate = new Date (info.start.setHours(info.start.getHours() + 2));
        // message d'alert pour l'user avec les dates selectionnees
        alert(`Vous avez sélectionné du ${info.start.toLocaleDateString()} au ${endDate.toLocaleDateString()}`);
        // la periode selectionnee sera en bg orange
        const cells = document.querySelectorAll('td[data-date]');
        const table = document.querySelector('.fc-scrollgrid-sync-table');
        table.addEventListener ('click', event => {
          cells.forEach(cell => {
          if (cell.classList.contains('selected-dates')) {
            cell.classList.remove('selected-dates');
          }
          if (cell.dataset.date >= info.startStr && cell.dataset.date < info.endStr ) {
            cell.classList.add('selected-dates');
          }
          })
        })
        // confirmer la resa: afficher les dates
        debut.innerHTML = `${startDate.toLocaleDateString()} au ${endDate.toLocaleDateString()}`;
        // confirmer la resa: calculer le prix
        let timeDifference = Math.abs(endDate - startDate);
        const msInDays = 1000*60*60*24;
        let numberOfDaysBooked = Math.ceil(timeDifference / msInDays + 1); //nb of milliseconds in a day

        if (discountList === null ) {
            totalPriceWithoutService = parseFloat((numberOfDaysBooked * officePrice ), 10);
        } else {
            discounts.forEach(discount => {
              let discountStart = new Date (discount.dataset.discountStart);
              let discountEnd = new Date(discount.dataset.discountEnd);
              let officePriceWithDiscount = parseFloat(officePrice - (officePrice * discount.dataset.discountAmount), 10);
              let numberOfDaysWithDiscount = 0;
              let numberOfDaysWithoutDiscount = 0;
              // la resa demarre av le debut du discount et se termine av la fin du discount
              if (startDate < discountStart && endDate >= discountStart && endDate <= discountEnd) {
                  numberOfDaysWithDiscount = Math.ceil(Math.abs(endDate - discountStart) / msInDays + 1);
              // la resa demarre av la fin du discount et se termine ap la fin du discount
              } else if (startDate <= discountEnd && endDate > discountEnd) {
                  numberOfDaysWithDiscount = Math.ceil(Math.abs(discountEnd - startDate) / msInDays + 1);
              // la resa est totalement incluse dans le discount
              } else if (discountStart <= startDate && discountEnd >= endDate) {
                  numberOfDaysWithDiscount = numberOfDaysBooked;
              }
              numberOfDaysWithoutDiscount = numberOfDaysBooked - numberOfDaysWithDiscount;
              totalPriceWithoutService = parseFloat((numberOfDaysWithDiscount * officePriceWithDiscount), 10)
                                        + parseFloat((numberOfDaysWithoutDiscount * officePrice), 10);
            })
        }
        if (document.querySelector('.priceSummarySpan') != null) {
            document.querySelector('.priceSummarySpan').remove();
        }
        priceDiv.insertAdjacentHTML('afterend', `<span class="priceSummarySpan"> ${totalPriceWithoutService} €</span>` );
      },
    });
    calendar.render();
  }
};

export { fullCalendar, totalPriceWithoutService } ;

