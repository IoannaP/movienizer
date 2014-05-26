function movieFormatResult(movie) {
    var markup = "<table class='movie-result'><tr>";
    if (movie.posters !== undefined && movie.posters.thumbnail !== undefined) {
        markup += "<td class='movie-image'><img src='" + movie.posters.thumbnail + "'/></td>";
    }
    markup += "<td class='movie-info'><div class='movie-title'>" + movie.title + "</div>";
    if (movie.critics_consensus !== undefined) {
        markup += "<div class='movie-synopsis'>" + movie.critics_consensus + "</div>";
    }
    else if (movie.synopsis !== undefined) {
        markup += "<div class='movie-synopsis'>" + movie.synopsis + "</div>";
    }
    markup += "</td></tr></table>";
    return markup;
}
 
function movieFormatSelection(movie) {
    return movie.title;
}

$("document").ready(function() {
    $(".input_field").select2({
        placeholder: "Search for a movie",
        minimumInputLength: 1,
        ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
            url: "http://api.rottentomatoes.com/api/public/v1.0/movies.json",
            dataType: 'jsonp',
            data: function (term, page) {
                return {
                    q: term, // search term
                    page_limit: 10,
                    apikey: "haak3yvy8dsw4gfxu8vprvnv" // please do not use so this example keeps working
                };
            },
            results: function (data, page) { // parse the results into the format expected by Select2.
                // since we are using custom formatting functions we do not need to alter remote JSON data
                return {results: data.movies};
            }
        },
        initSelection: function(element, callback) {
            // the input tag has a value attribute preloaded that points to a preselected movie's id
            // this function resolves that id attribute to an object that select2 can render
            // using its formatResult renderer - that way the movie name is shown preselected
            var id=$(element).val();
            if (id!=="") {
                $.ajax("http://api.rottentomatoes.com/api/public/v1.0/movies/"+id+".json", {
                    data: {
                        apikey: "haak3yvy8dsw4gfxu8vprvnv"
                    },
                    dataType: "jsonp"
                }).done(function(data) { callback(data); });
            }
        },
        formatResult: movieFormatResult, // omitted for brevity, see the source of this page
        formatSelection: movieFormatSelection,  // omitted for brevity, see the source of this page
        dropdownCssClass: "bigdrop", // apply css that makes the dropdown taller
        escapeMarkup: function (m) { return m; } // we do not want to escape markup since we are displaying html in results
    });
});
