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

      $(document).on('click', '.remove_fields', function(){
        setTimeout(function(){
          validators.destroy();
          validators = validateForm(form)
        }, 200)
      })

      $('.primary-exists').on('change', function(){
        $this = $(this);
        if($this.prop('checked')) {
          confirmed = confirm("A primary rate card of " + $this.data('type') + " type is already exists. Do yo want to change?");
          $this.prop('checked', confirmed)
        }
      })
    }
  }

  function validateForm(form){
    var fields = {}
    $(form).find('.required:not(:hidden)').each(function(i, e){
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
