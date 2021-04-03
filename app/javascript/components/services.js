
const services = () => {

  const serviceField = document.querySelector('.services-fields');
  serviceField.addEventListener('change', function(){
    const services = document.querySelectorAll('.service');
    const serviceInfo = document.querySelector('.fa-concierge-bell');
    services.forEach(function(service, index) {
      let first = service.firstElementChild.lastElementChild;
      let second = service.lastElementChild.lastElementChild;
      let price = first.dataset.price;
      service.addEventListener('change', event => {
        if (document.getElementById(`${index}`) != null){
          document.getElementById(`${index}`).remove();
        }
        if ((first.value != '') && (second.value != '')){
          let text;
          first.querySelectorAll('option').forEach(option => {
            if (option.value === first.value) {
              text = second.value <= 1 ? option.innerText : (option.innerText + 's')
            }
          });
          serviceInfo.insertAdjacentHTML('afterend', `<span id=${index}> ${second.value} ${text}</span>` );
        }
      })
    });
  })
};


export { services }
