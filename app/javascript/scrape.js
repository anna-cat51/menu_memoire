console.log("hello!")
document.addEventListener("turbo:load", function () {
  document.getElementById("scrape-button").addEventListener("click", function (e) {
    e.preventDefault();
    var recipeUrl = document.getElementById("recipe_url").value;
    
    // CSRFトークンを取得
    var token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

    // ingredients変数を定義
    var ingredients = [];

    fetch('/repertoires/scrape', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': token // CSRFトークンをヘッダーに追加
      },
      body: JSON.stringify({ recipe_url: recipeUrl })
    })
    .then(response => response.json())
    .then(data => {
      console.log(data.ingredients);
      // スクレイピング結果をingredients変数に代入
      var ingredients = data.ingredients;
      // スクレイピング結果をフォームに反映
      document.getElementById("repertoire_ingredient_names").value = ingredients.join(", ");
    })
    .catch(error => console.error('Error:', error)); // エラーハンドリングを追加
  });
});
