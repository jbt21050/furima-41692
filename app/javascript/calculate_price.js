document.addEventListener('DOMContentLoaded', () => {
  const priceInput = document.getElementById('item-price'); // 価格の入力欄
  const addTaxDom = document.getElementById('add-tax-price'); // 販売手数料を表示する場所
  const profitDom = document.getElementById('profit'); // 販売利益を表示する場所

  priceInput.addEventListener('input', () => {
    const inputValue = priceInput.value; // 入力された価格

    if (!isNaN(inputValue) && inputValue >= 300 && inputValue <= 9999999) {
      const tax = Math.floor(inputValue * 0.1); // 手数料計算（10%）
      const profit = inputValue - tax; // 利益計算
      addTaxDom.textContent = tax.toLocaleString(); // 手数料を表示
      profitDom.textContent = profit.toLocaleString(); // 利益を表示
    } else {
      addTaxDom.textContent = '0'; // 範囲外の場合は初期化
      profitDom.textContent = '0';
    }
  });
});
