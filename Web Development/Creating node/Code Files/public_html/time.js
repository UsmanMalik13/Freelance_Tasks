function displayTimeWithOffset(offset, timeZone) {
    var now = new Date();
    var localTime = now.getTime();
    var localOffset = now.getTimezoneOffset() * 60000;
    var utc = localTime + localOffset;

    var newTime = utc + (3600000 * offset);
    var convertedTime = new Date(newTime);

    var options = {
        timeZone: timeZone,
        hour: 'numeric',
        minute: 'numeric',
        second: 'numeric'
    };

    var formattedTime = convertedTime.toLocaleString('en-US', options);
    document.getElementById('time').innerText = "Time: " + formattedTime + " GMT" + (offset >= 0 ? '+' : '') + offset + "00 (Australian Eastren Standard Time)";
}

// Example usage: Display time with an offset of +5 and in the "Asia/Kolkata" time zone
displayTimeWithOffset(10, "Australia/Sydney");