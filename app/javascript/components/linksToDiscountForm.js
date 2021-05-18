const linksToDiscountForm = () => {

  let linksToDiscountForm = document.querySelectorAll('.add_discount');
  const forms = document.querySelectorAll('.discount-form');
  if (linksToDiscountForm) {
      linksToDiscountForm.forEach( linkToDiscountForm => {
            linkToDiscountForm.addEventListener('click', event => {
                if (linkToDiscountForm.innerText === 'Ajouter une réduction ▽') {
                  linkToDiscountForm.innerText = 'Ajouter une réduction △';
                } else if (linkToDiscountForm.innerText === 'Ajouter une réduction △'){
                  linkToDiscountForm.innerText = 'Ajouter une réduction ▽';
                }
                forms.forEach(form => {
                  if (form.dataset.number === event.currentTarget.dataset.number){;
                    form.classList.toggle('hide-discount-form');
                    form.classList.toggle('show-discount-form');
                  }
                });
            })
      })
  }
}

export { linksToDiscountForm }
