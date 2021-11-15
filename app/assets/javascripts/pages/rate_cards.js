$(document).ready(function(){
  if($('body.rate_cards').length){
    var form = KTUtil.getById('rate-card-form')
    var check = document.getElementById('rate_card_primary')

    if(form) {
      var validators = validateForm(form)

      $('#add-btn').click(function(){
        $('.links a').trigger('click');
        validators.destroy();
        validators = validateForm(form)
        return false;
      })

      $(document).on('click', '.remove_fields', function(){
        setTimeout(function(){
          validators.destroy();
          validators = validateForm(form)
        }, 200)
      })

      $('.primary-exists').on('click', function(){
        show_confirm(rate_card_primary)
      })

    }
  }

  function validateForm(form){
    var fields = {}
    $(form).find('input.required:not(:hidden)').each(function(i, e){
      fields[$(e).attr('name')] = {
        validators: {
          notEmpty: {
            message: 'Field is required'
          }
        }
      }
    })

    return FormValidation.formValidation(
      form,
      {
        fields: fields,
        plugins: {
          trigger: new FormValidation.plugins.Trigger(),
          submitButton: new FormValidation.plugins.SubmitButton(),
          bootstrap: new FormValidation.plugins.Bootstrap({
          })
        }
      }
    )
    .on('core.form.valid', function() {
      form.submit();
    })
    .on('core.form.invalid', function() {
      KTUtil.scrollTop();
    });
  }

  function show_confirm(check) {
    if (check.checked == false) {
      return false;
    } else {
     var box= confirm("A primary rate card of interest rate type is already exists. Do yo want to change?");
      if (box==true)
          return true;
      else
         check.checked = true;
    }
  }
})

