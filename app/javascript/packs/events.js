jQuery(() => {
    $(function () {
        var availableTags = [
            "Created by Pradeep",
            "Created by Prem",
            "test",
            "vennila"
        ];
        $("#tags").autocomplete({
            source: availableTags
        });
    });

    $( function() {
        $( "#datepicker" ).datepicker({dateFormat: 'yy-mm-dd'});
    } );

    $( function() {
        $( "#datepicker1" ).datepicker({dateFormat: 'yy-mm-dd'});
    } );
})
