window.addEventListener("pageshow", function() {
    document.body.classList.add('slide-in-active');
});

function animateAndRedirect(event, url) {
    event.preventDefault();

    
    document.body.classList.add('slide-out');

    
    setTimeout(function() {
        window.location.href = url;
    }, 400);  
}

function goBack(event) {
    event.preventDefault();

    
    document.body.classList.add('slide-out');

    
    setTimeout(function() {
        window.history.back();
    }, 400);  
}
