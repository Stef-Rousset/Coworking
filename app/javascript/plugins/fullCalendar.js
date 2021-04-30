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
  // en rapport avec la deselection des dates deja bookees
  const datesArray = document.querySelector('.dates-array');
  // Returns an array of dates between the two dates
  function getDatesBetween(startDate, endDate){
      const dates = [];
      // Strip hours minutes seconds etc.
      let currentDate = new Date(
          startDate.getFullYear(),
          startDate.getMonth(),
          startDate.getDate()
      );
      while (currentDate <= endDate) {
          dates.push(currentDate);

          currentDate = new Date(
              currentDate.getFullYear(),
              currentDate.getMonth(),
              currentDate.getDate() + 1, // Will increase month if over range
          );
      }
      return dates;
  };

  if (formStartDate) {
      // recuperer le prix
      const office = document.querySelector('.office-title');
      const officePrice = (office.dataset.officePrice) * 60 * 7;
      // confirmer la resa : recup l'element ou inserer les dates
      const debut = document.querySelector('.debut');
      // confirmer la resa : recup l'element ou inserer le prix
      const priceDiv = document.querySelector('.priceSummary');
      // recup la div d'insertion du calendrier
      const calendarEl = document.querySelector('.calendar');
      // creer le calendrier
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
              // construire un array avec les dates selectionnées
              let arrayOfSelectedDates = getDatesBetween(info.start, info.end);
              const finalRangeOfDates = arrayOfSelectedDates.map(date => {
                return date.toISOString().substring(0, 10); // format "YYYY-MM-DD"
              })
              finalRangeOfDates.shift();
              // construire un array avec les dates en commun
              const unavailableDates = JSON.parse(datesArray.innerText); // transfo la string en array
              let datesInCommon = finalRangeOfDates.filter(value => unavailableDates.includes(value));
              // recup la grille et les cellules
              const table = document.querySelector('.fc-scrollgrid-sync-table');
              const cells = document.querySelectorAll('td[data-date]');
              // au select sur une date déjà booked, disable les dates non dispo
              // et remettre à zero la zone confirm resa
              if (datesInCommon.length != 0) {
                  alert(' Date not available');
                  table.addEventListener ('click', event => {
                    cells.forEach(cell => {
                        if (datesArray.innerText.includes(cell.dataset.date)){
                            cell.classList.add('disabled');
                        }
                        if (cell.classList.contains('selected-dates')){
                          cell.classList.remove('selected-dates');
                        }
                    })
                  })
                  if (document.querySelector('.priceSummarySpan') != null) {
                      document.querySelector('.priceSummarySpan').remove();
                  }
                  debut.innerHTML = "";
              } else {
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
                  // pas de discount ou un discount passe
                  if (discountList === null || discounts.length === 0) {
                      totalPriceWithoutService = parseFloat((numberOfDaysBooked * officePrice ), 10);
                  } else {
                      let discountPricesArray = [];
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
                        discountPricesArray.push(parseFloat((numberOfDaysWithDiscount * officePriceWithDiscount), 10)
                                                  + parseFloat((numberOfDaysWithoutDiscount * officePrice), 10));
                      })
                      totalPriceWithoutService = discountPricesArray.reduce(function(acc,currV){ return acc + currV; });
                  }
                  if (document.querySelector('.priceSummarySpan') != null) {
                      document.querySelector('.priceSummarySpan').remove();
                  }
                  priceDiv.insertAdjacentHTML('afterend', `<span class="priceSummarySpan"> ${totalPriceWithoutService} €</span>` );
              }
          }
      });
    calendar.render();
  }
};

export { fullCalendar, totalPriceWithoutService } ;

