import sample64 from "./sample64.js"

function LinkClick() {
  sample64 = ''
  console.log('start click')
  console.log(sample64)
  var elem = document.getElementById("image01");
  elem.src = sample64;
}
