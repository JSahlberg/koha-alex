// Alex test

  function getAlex(writer, title) {

    var alexpw = '**********'; // Password
    var alexWriter = writer;
    var alexTitle = title;
    var cardnumber = '**********';  // Cardnumber

    $.ajaxSetup({
      error: function(xhr, status, error) {
        console.log("An AJAX error occured: " + status + "\nError: " + error);
      }
    });

    var jsondata;

    $.get('alex-test.pl?&writer=' + alexWriter + '&title=' + alexTitle).done(function(data) {
      jsondata = data;
      console.log(data);

      alexFound = jsondata.response.writers.found.toString();
      if (alexFound == '1') {
        alexArticle = jsondata.response.writers.writer.article.toString().trim();
        if (alexArticle.slice(-2).indexOf('.') == -1) {
          alexArticle = alexArticle.concat('...');
        }
        alexImageUrl = jsondata.response.writers.writer.imageUrl.toString();
        if (alexImageUrl.indexOf('noimage') > -1) {
          alexImageUrl = '';
          alexImageText = '';
        } else {
          alexImageText = jsondata.response.writers.writer.imageText.toString();
          console.log(alexImageText);
          if (alexImageText.indexOf('[object]') > -1 ) {
            alexImageText = '';
          }

        }
        alexName = jsondata.response.writers.writer.name.toString();
        alexBornDeadText = jsondata.response.writers.writer.bornDeadText.toString();
        alexLogotype = jsondata.response.writers.writer.alexLogotype.toString();
        alexLinkUrl = jsondata.response.writers.writer.alexLinkUrl.toString();
      };
      //console.log(jsondata);
    });
  };

  function alexDiv() {
    $('<div id="alexwindow" style="padding-top:15px"></div>').insertAfter('#ulactioncontainer');
    $('#alexwindow').append('<div id="alexImg"><img src="'+ alexImageUrl +'" style="display:block;max-height:240px;"></div>');
    $('#alexImg').append('<span class="results_summary" style="font-size:80%;">'+ alexImageText +'</span>');
    $('#alexwindow').append('<h3 class="author">'+ alexName +'</h3>');
    $('#alexwindow').append('<h5>'+ alexBornDeadText +'</h5>');
    $('#alexwindow').append('<span class="results_summary" style="font-size:85%">' + alexArticle + '</span>');
    $('#alexwindow').append('<span class="results_summary"><a href="'+ alexLinkUrl +'" target="_blank">Läs mer på Alex.se</a></span>');
    $('#alexwindow').append('<div style="display:block;float:right"><img src="'+ alexLogotype +'" style="width:80px;"></div>');
  };

  function waitForVar(variable, callback) {

     if (alexFound == '1' || alexFound == '0') {
       console.log('Variable found! Value is: ' + alexFound);
       callback();
     } else {
       console.log('Not found yet...');
       setTimeout(function() {
         waitForVar(variable, callback);
       },100)
     }
  };

  var alexFound;
  var alexArticle;
  var alexImageUrl;
  var alexImageText;
  var alexName;
  var alexBornDeadText;
  var alexLogotype;
  var alexLinkUrl;

  if ($('#opac-detail').length) {
    getAlex($('.author:first span[property="name"]').justtext().replace(/-/g, " "));

    waitForVar('alexFound', function() {
      if (alexFound == '1') {
        alexDiv();
      };
    });


  };
