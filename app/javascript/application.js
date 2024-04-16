// Entry point for the build script in your package.json
import "@hotwired/turbo-rails";
import "./controllers";
import "./preview";
import "./scrape";

import "./src/jquery"
// import "@nathanvda/cocoon";

$(function () {
  console.log("hello world");
});
