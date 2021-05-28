const homeSearchForm = () => {

  const introText = document.querySelector('.intro-text');
  const button = document.querySelector('.home-search');
  const form = document.querySelector('.home-search-form');

  if (introText) {
      button.addEventListener('click', event => {
          form.classList.toggle('hide-home-search-form');
          form.classList.toggle('show-home-search-form');
      })
  }

}
export { homeSearchForm };
