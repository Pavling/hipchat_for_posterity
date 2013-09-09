window.onload = function() {

  var exampleValues = {},
    previousDate = "",
    previousPoster = "",
    parsedTemplate = "",

    postText = $('#postTemplate').html(),
    dateText = $('#dateTemplate').html(),

    postTemplate = _.template(postText);
    dateTemplate = _.template(dateText);
  $.ajax({url: "js/chat_data.json", async: false, dataType: "json", success: function(json) {exampleValues = json;}});
  // The for loop runs the values for each employee through the
  // demoTemplate function, and builds the parsedTemplate HTML
  // from the results.
  _.each(exampleValues, function(post) {
    currentPoster = (typeof post['from'] != 'undefined') ? post['from']['name'] : '';
    currentDate = moment(post['date']).format('MMM Do YYYY');

    post['message'] = post['message'].replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");


    if(previousDate != currentDate) {
      parsedTemplate += dateTemplate({date: post['date']});
    }
    previousDate = currentDate;

    post['cssClass'] = (previousPoster===currentPoster ? 'continuation' : '');
    parsedTemplate += postTemplate(post);
    previousPoster = currentPoster;
  });
  // The rest of the page is the same as the previous example.
  $("#postsBlock").html(parsedTemplate);

};
