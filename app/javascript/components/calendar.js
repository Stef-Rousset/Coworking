//import jsCalendar from "js-calendar"

const calendar = () => {
const targetDiv = document.querySelector('.office-reservation');

if (targetDiv) {
    const jsCalendar = require('js-calendar');
    const monthNames = ["January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"];

    let currentYear = new Date().getFullYear(); //2021
    let indexMonth = new Date().getMonth(); // 2
    let currentMonth = monthNames[indexMonth]; // March

    const buttonOne = document.querySelector('.btnOne');
    const buttonTwo = document.querySelector('.btnTwo');
    const target = document.querySelector('.calendar');
    const monthDiv = document.querySelector('.month');
    monthDiv.innerHTML = currentMonth + ' - ' + currentYear;

    generateCalendar(currentYear, indexMonth);
    buttonOne.addEventListener('click', changeMonth(-1));
    buttonTwo.addEventListener('click', changeMonth(+1));

    function generateCalendar(currentYear, indexMonth){
      if (target.firstElementChild) {
        target.firstElementChild.remove();
      }
      const div = document.createElement('div');
      target.appendChild(div);
      let generator = new jsCalendar.Generator({weekStart: 0});
      generator(currentYear, indexMonth, jsCalendar.addLabels).cells.forEach(function(cell, c) {
        const cellDiv = document.createElement('div');
         // add classes from "addLabels" plugin
        cellDiv.className = cell.class.join(' ');
        // add day number or 3 character long weekday label
        cellDiv.innerHTML = typeof cell.desc == 'string' ? cell.desc.slice(0, 3) : cell.desc;
        div.appendChild(cellDiv);
      });
    }
    function changeMonth(direction) {
      return function() {
        indexMonth += direction;
        if (indexMonth === -1) {
          currentMonth = monthNames[11];
          currentYear -= 1;
          monthDiv.innerHTML = currentMonth + ' - ' + currentYear;
          indexMonth = 11;
          generateCalendar(currentYear, indexMonth);
        } else if (indexMonth >= 0 && indexMonth < 12) {
          currentMonth = monthNames[indexMonth];
          monthDiv.innerHTML = currentMonth + ' - ' + currentYear;
          generateCalendar(currentYear, indexMonth);
        } else if (indexMonth === 12) {
          currentMonth = monthNames[0];
          currentYear += 1;
          monthDiv.innerHTML = currentMonth + ' - ' + currentYear;
          indexMonth = 0;
          generateCalendar(currentYear, indexMonth);
        }
      }
    }

    const dates = document.querySelectorAll('.day-in-month');
    let startCell;
    let startDate;
    let endCell;
    let endDate;

    dates.forEach(date => {
      date.addEventListener('click', handleClick);
    })

    function handleClick(event){
        if (document.querySelectorAll('.selected').lenght === 2) {
          div.style.pointerEvents = 'none';
        } else if (typeof startDate === 'undefined') {
          startCell = event.currentTarget;
          startCell.classList.add('selected');
          startDate = new Date(currentYear,indexMonth, parseInt(startCell.innerHTML,10));
          endDate = new Date(currentYear,indexMonth, parseInt(startCell.innerHTML,10));
          console.log(startDate);
          console.log(endDate);
        } else if (typeof startDate === 'object') {
          endCell = event.currentTarget;
          endCell.classList.add('selected');
          startDate  = new Date(currentYear,indexMonth, parseInt(startCell.innerHTML,10));
          endDate  = new Date(currentYear,indexMonth, parseInt(endCell.innerHTML,10));
          console.log(startDate);
          console.log(endDate);
        }
    }

    // dates.forEach(date => function(){
    //   if ( typeof endDate === 'object' && parseInt(date.innerHTML, 10) > parseInt(startCell.innerHTML,10)
    //        && parseInt(date.innerHTML, 10) < parseInt(endCell.innerHTML, 10)) {
    //         date.classList.add('selected');
    //       }
    // })
  }
}

export { calendar }

