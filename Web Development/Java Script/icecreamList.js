// Ice cream flavors array
const iceCreamFlavors = [
    "Vanilla",
    "Chocolate",
    "Cookies 'n Cream",
    "Strawberry",
    "Chocolate Chip",
    "Mint Chocolate Chip",
    "Chocolate Chip Cookie Dough",
    "Butter Pecan",
    "Birthday Cake",
    "Moose Tracks"
  ];
  
  // Function to build ice cream list
  function buildIcecreamList() {
    const topIcecreamsDiv = document.getElementById("top_icecreams");
  
    // Clear existing content
    topIcecreamsDiv.innerHTML = "";
  
    // Create ordered list element
    const olElement = document.createElement("ol");
  
    // Loop through ice cream flavors and create list items
    iceCreamFlavors.forEach(flavor => {
      const liElement = document.createElement("li");
      liElement.textContent = flavor;
      olElement.appendChild(liElement);
    });
  
    // Append the ordered list to the top_icecreams div
    topIcecreamsDiv.appendChild(olElement);
  }
  