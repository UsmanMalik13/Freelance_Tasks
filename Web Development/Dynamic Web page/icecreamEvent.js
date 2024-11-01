// Get references to the button and div elements
const button = document.getElementById('clickButton');
const messageDiv = document.getElementById('top_icecreams');
let counter = 0;

// Function to update the message content and button text
function updateMessage() {
    // Get the current date and time
    const currentDate = new Date();
    const options = { hour: '2-digit', minute: '2-digit', second: '2-digit', timeZoneName: 'short' };
    const timeFormatter = new Intl.DateTimeFormat('en', options);
    const currentTime = timeFormatter.format(currentDate);

    // Get the current time zone abbreviation (GMT offset) for the user's region
    const timeZoneAbbr = Intl.DateTimeFormat().resolvedOptions().timeZone;

    // Update the message content
    messageDiv.innerHTML = `<h3>Well done, you clicked the button!</h3>
    <ul>
        <li>At time:<i> ${currentTime} (${timeZoneAbbr})</i></li>
        <li>On date:<i> ${currentDate.toDateString()}</i></li>
    </ul>
    <h6>Move your cursor/mouse over this div element to change the background color to violet.</h6>`;

    // Increment the counter and update button text
    counter++;
    button.value = `Try again... Pressed ${counter} times`;

    // Check if button has been clicked more than 5 times
    if (counter > 5) {
        // Hide the messageDiv
        messageDiv.style.display = 'none';
        // Reset the counter
        counter = 0;
        // Update button text
        button.value = 'Click to Re-start';
    } else {
        // Show the messageDiv
        messageDiv.style.display = 'block';
    }
}

// Add onclick event handler to the button
button.addEventListener('click', updateMessage);

// Add onmouseover event handler to the messageDiv
messageDiv.addEventListener('mouseover', function() {
    // Change background color to Violet
    messageDiv.style.backgroundColor = 'Violet';
});

// Add onmouseout event handler to the messageDiv
messageDiv.addEventListener('mouseout', function() {
    // Change background color back to its original color
    messageDiv.style.backgroundColor = '';
});
