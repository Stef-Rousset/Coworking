
const buildingCardsTranslate = () => {
  const buildingCards = document.querySelectorAll('.building-card');

  if (buildingCards) {
      buildingCards.forEach( buildingCard => {
        window.addEventListener('scroll', event => {
          if (window.pageYOffset >= 650 && buildingCard.dataset.index % 2 === 0) {
              buildingCard.classList.add('translate-building-card-left');
          } else if (window.pageYOffset >= 550 && buildingCard.dataset.index % 2 != 0) {
              buildingCard.classList.add('translate-building-card-right');
          }
        })
      })
  }
}

export { buildingCardsTranslate }
