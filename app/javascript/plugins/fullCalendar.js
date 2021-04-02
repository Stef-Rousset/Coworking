import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import interactionPlugin from '@fullcalendar/interaction';

const fullCalendar = () => {

  let formStartDate = document.querySelector('#booking_start_date');
  let formEndDate = document.querySelector('#booking_end_date');
  const debut = document.querySelector('.debut');

  if (formStartDate) {
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
      //dateClick: function(info) {
      //alert('Clicked on: ' + info.dateStr);
      // change the day's background color just for fun

        //info.dayEl.style.backgroundColor = 'orange';
      //},
      select: function(info) {
        alert('Vous avez sélectionné du ' + info.startStr + ' au ' + info.endStr);
        formStartDate.value = info.start;
        let endDate = info.end;
        formEndDate.value = new Date (endDate.setDate( endDate.getDate() - 1 ));
        const cells = document.querySelectorAll('td[data-date]');
        cells.forEach(cell => {
          if (cell.dataset.date >= info.startStr && cell.dataset.date < info.endStr ) {
            cell.firstElementChild.classList.add('selected-dates');
          }
        })
        debut.innerHTML = `${info.start.toLocaleDateString()} au ${info.end.toLocaleDateString()}`;
      }
    });
    calendar.render();
  }
};

export { fullCalendar } ;
