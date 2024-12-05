const pay = () => {
  Payjp.setPublicKey("公開鍵をここに記述"); // Pay.jp 公開鍵
  const form = document.getElementById("charge-form");
  form.addEventListener("submit", (e) => {
    e.preventDefault();

    const formResult = new FormData(form);
    const card = {
      number: formResult.get("number"),
      cvc: formResult.get("cvc"),
      exp_month: formResult.get("exp_month"),
      exp_year: `20${formResult.get("exp_year")}`,
    };

    Payjp.createToken(card, (status, response) => {
      if (status === 200) {
        const token = response.id;
        const tokenObj = `<input value=${token} name='token' type="hidden"> `;
        form.insertAdjacentHTML("beforeend", tokenObj);
        form.submit();
      } else {
        alert("カード情報が正しくありません");
      }
    });
  });
};

window.addEventListener("load", pay);
