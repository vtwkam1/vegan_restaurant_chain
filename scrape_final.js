var url ='https://deliveroo.co.uk/menu/sheffield/ecclesall-road/sheffield-ecclesall-road-pizzaexpress';
var page = new WebPage()
var fs = require('fs');


page.open(url, function (status) {
    just_wait();
});

function just_wait() {
    setTimeout(function() {
        fs.write('1.html', page.content, 'w');
        phantom.exit();
    }, 2500);
}
