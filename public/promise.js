function getJSON(url) {
  return new Promise(function(resolve, reject) {
    var request = new XMLHttpRequest();
    request.open('GET', url, true);

    request.onload = function() {
      if (request.status >= 200 && request.status < 400) {
        var data = JSON.parse(request.responseText);
        resolve(data);
      } else {
        reject({statusText: this.statusText,
                status: this.status,
                responseText: this.responseText})
      }
    };

    request.onerror = function(progressEvent) {
      reject(progressEvent.type)
    };

    request.send();
  });
}

// var getRequests = Promise.all([
//   getJSON("/three_second_route"),
//   getJSON("/five_second_route"),
//   getJSON("/eight_second_route"),
//   getJSON("/random_delay_route")
//   ]).then(function(values) {
//     console.log(values);
//   });
