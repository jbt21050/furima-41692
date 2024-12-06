// app/javascript/packs/payjp.js
document.addEventListener('DOMContentLoaded', () => {
  if (!gon.public_key) {
    console.error('PAY.JPの公開鍵が設定されていません。');
    return;
  }

  const payjp = Payjp(gon.public_key);
  const elements = payjp.elements();
  card.mount('#card-element');

  const form = document.getElementById('charge-form');
  form.addEventListener('submit', async (event) => {
    event.preventDefault();

    const { token, error } = await payjp.createToken(card);
    if (error) {
      const errorElement = document.getElementById('card-errors');
      errorElement.textContent = error.message;
    } else {
      const hiddenInput = document.createElement('input');
      hiddenInput.setAttribute('type', 'hidden');
      hiddenInput.setAttribute('name', 'payjp-token');
      hiddenInput.setAttribute('value', token.id);
      form.appendChild(hiddenInput);

      // カード情報のフィールドをクリア
      card.clear();

      // フォームを送信
      form.submit();
    }
  });
});
