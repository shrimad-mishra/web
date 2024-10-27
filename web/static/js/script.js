document.getElementById('productForm').addEventListener('submit', function(event) {
    event.preventDefault();

    // Get form data
    const productName = document.getElementById('name').value;
    const productDescription = document.getElementById('description').value;

    // Prepare data to send in the request
    const productData = {
        name: productName,
        description: productDescription
    };

    // Send POST request using Fetch API
    fetch('/save', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'X-CSRFToken': getCSRFToken() // For Django, include CSRF token if applicable
        },
        body: JSON.stringify(productData)
    })
    .then(response => response.json())
    .then(data => {
        // Display the response message
        const responseMessage = document.getElementById('responseMessage');
        if (data.status === 200) {
            responseMessage.innerHTML = `<p style="color: green;">${data.message}</p>`;
        } else {
            responseMessage.innerHTML = `<p style="color: red;">${data.message}</p>`;
        }
    })
    .catch(error => {
        console.error('Error:', error);
    });
});

// Function to get CSRF token from cookie (for Django)
function getCSRFToken() {
    const name = 'csrftoken';
    const cookieValue = document.cookie.split('; ')
        .find(row => row.startsWith(name))
        ?.split('=')[1];
    return cookieValue;
}
