$(function () {
    $('button#load').on('click', function (ev) {
        $(this).prop("disabled", true);
        $(this).val('Submitting');
        $(this).parents('form').submit();
        $('img#loading').toggleClass('passive');
        $('div#fill-div').toggleClass('passive');
    });
    $('input[id=lefile]').change(function () {
        $('#photoCover').val($(this).val());
    });
});
