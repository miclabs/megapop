$(document).ready(function(){
  if($('body.rate_cards').length){
    var form = KTUtil.getById('rate-card-form')

    if(form) {  
      var validators = validateForm(form)

      $('#add-btn').click(function(){
        $('.links a').trigger('click');
        validators.destroy();
        validators = validateForm(form)
        return false;
      })
    }
  }

  function validateForm(form){
    var fields = {}
    $(form).find('input.required').each(function(i, e){
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
})
        
