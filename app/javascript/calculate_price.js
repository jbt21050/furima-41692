function salesPrice() {
  const priceInput = document.getElementById('item-price');
  const addTaxDom = document.getElementById('add-tax-price');
  const profitDom = document.getElementById('profit');

  if (!priceInput || !addTaxDom || !profitDom) return;

  priceInput.addEventListener('input', () => {
    const inputValue = parseInt(priceInput.value, 10);

    if (!isNaN(inputValue) && inputValue >= 300 && inputValue <= 9999999) {
      const tax = Math.floor(inputValue * 0.1);
      const profit = inputValue - tax;
      addTaxDom.textContent = tax.toLocaleString();
      profitDom.textContent = profit.toLocaleString();
    } else {
      addTaxDom.textContent = '0';
      profitDom.textContent = '0';
    }
  });
}

document.addEventListener('turbo:load', salesPrice);
document.addEventListener('turbo:render', salesPrice);
