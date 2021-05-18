const customModal = () => {

  let validateDiscountsButtons = document.querySelectorAll('.validate-discount');

  //let customModals = document.querySelectorAll('.custom-modal');

  let discountTags = document.querySelectorAll('.fa-tag');
  //let modalCloseButtons = document.querySelectorAll('.close-custom-modal');


  if (validateDiscountsButtons) {
    function hasClass(elem, className) {
    return elem.classList.contains(className);
    }
    let modalCloseButtons;
    let modalCloseButton;
    let customModals;
    let customModal;
    document.addEventListener('click', function (event) {
        if (hasClass(event.target, 'fa-tag')) {
            customModals = document.querySelectorAll('.custom-modal');
            modalCloseButtons = document.querySelectorAll('.close-custom-modal');

                // transfo la NodeList customModals en array
                customModal = Array.from(customModals).find( customModal => customModal.dataset.id === event.target.dataset.id);
                customModal.classList.toggle('hide-modal');
                customModal.classList.toggle('show-modal');
        }
        if (modalCloseButtons != undefined) {
        modalCloseButton = Array.from(modalCloseButtons).find( modalCloseButton => modalCloseButton.dataset.id === event.target.dataset.id);
            if (modalCloseButton != undefined) {
                modalCloseButton.addEventListener('click', event => {
                    customModal.classList.toggle('hide-modal');
                    customModal.classList.toggle('show-modal');
                })
            }
        }
    }, false);
  }
}

export { customModal }
