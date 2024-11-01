function processText() {
    // Get input values
    var inputString = document.getElementById("exampleFormControlTextarea1").value;
    var searchString = document.getElementById("searchWord").value.toLowerCase();
    var substringSize = parseInt(document.getElementById("numberCharacters").value);

    // Check if input string or search string is empty
    if (inputString.trim() === "" || searchString.trim() === "") {
        alert("Ensure you input a value in both fields!");
        return;
    }

    // Display total number of characters
    document.getElementById("strResult1").innerText = inputString.length;

    // Display input string in uppercase
    document.getElementById("strResult2").innerText = inputString.toUpperCase();

    // Display input string in lowercase
    document.getElementById("strResult3").innerText = inputString.toLowerCase();

    // Find starting position of search string (case insensitive)
    var startPosition = inputString.toLowerCase().indexOf(searchString);
    document.getElementById("strResult4").innerText = startPosition !== -1 ? startPosition : -1;

    // Display first n characters of input string
    document.getElementById("strResult5").innerText = inputString.substring(0, substringSize);

    // Display last n characters of input string
    document.getElementById("strResult6").innerText = inputString.substring(inputString.length - substringSize);
}

function clearText() {
    // Clear input fields
    document.getElementById("exampleFormControlTextarea1").value = "";
    document.getElementById("searchWord").value = "";
    document.getElementById("numberCharacters").value = "";

    // Clear result fields
    document.getElementById("strResult1").innerText = "";
    document.getElementById("strResult2").innerText = "";
    document.getElementById("strResult3").innerText = "";
    document.getElementById("strResult4").innerText = "";
    document.getElementById("strResult5").innerText = "";
    document.getElementById("strResult6").innerText = "";
}
