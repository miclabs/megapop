$(document).ready(function(){
  if($('body.rate_cards').length){
    var form = KTUtil.getById('rate-card-form')

    if(form) {  
      FormValidation.formValidation(
        form,
        {
          fields: {
            'rate_card[name]': {
              validators: {
                notEmpty: {
                  message: 'Name is required'
                }
              }
            },
            'rate_card[rates_attributes][0][rate]': {
              validators: {
                notEmpty: {
                  message: 'Rate is required'
                }
              }
            },
            'rate_card[rates_attributes][1][rate]': {
              validators: {
                notEmpty: {
                  message: 'Rate is required'
                }
              }
            },
            'rate_card[rates_attributes][2][rate]': {
              validators: {
                notEmpty: {
                  message: 'Rate is required'
                }
              }
            },
            'rate_card[rates_attributes][0][days]': {
              validators: {
                notEmpty: {
                  message: 'Day is required'
                }
              }
            },
            'rate_card[rates_attributes][1][days]': {
              validators: {
                notEmpty: {
                  message: 'Day is required'
                }
              }
            },
            'rate_card[rates_attributes][2][days]': {
              validators: {
                notEmpty: {
                  message: 'Day is required'
                }
              }
            }
          },
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

      $('#add-btn').click(function(){
        $('.links a').trigger('click');
        $('#add-btn').toggle($('.nested-fields:not(:hidden)').length < 3)
        return false;
      })

      $('.remove_fields').click(function(){
        $('#add-btn').toggle($('.nested-fields:not(:hidden)').length < 3)
      })
    }
  }
})
        
