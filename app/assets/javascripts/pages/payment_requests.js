$(document).ready(function(){
  if($('body.payment_requests').length){ 
    const XHRUpload = Uppy.XHRUpload;
    const ProgressBar = Uppy.ProgressBar;
    const StatusBar = Uppy.StatusBar;
    const Informer = Uppy.Informer;

    var form = KTUtil.getById('payment_requests_form');

    var initUploadDocument = function(){
      var id = '#kt_uppy_3';
      let field_name = 'payment_request[project_documents][]'

      var uppyDrag = Uppy.Core({
        autoProceed: true,
        restrictions: {
          maxFileSize: 1000000, // 1mb
          maxNumberOfFiles: 5,
          minNumberOfFiles: 1,
          allowedFileTypes: [".pdf", ".xlsx", '.doc', '.docx', 'image/*']
        }
      });

      uppyDrag.use(Uppy.DragDrop, { target: id + ' .uppy-drag' });
      uppyDrag.use(ProgressBar, {
        target: id + ' .uppy-progress',
        hideUploadButton: false,
        hideAfterFinish: false
      });
      uppyDrag.use(Informer, { target: id + ' .uppy-informer'  });
      uppyDrag.use(XHRUpload, { endpoint: '/payment_requests/upload' });

      uppyDrag.on('complete', function(file) {
        var imagePreview = "";
        $.each(file.successful, function(index, value){
          var imageType = /image/;
          var thumbnail = "";
          if (imageType.test(value.type)){
            thumbnail = '<div class="uppy-thumbnail"><img src="'+value.response.body.uploadURL+'"/></div>';
          }
          var sizeLabel = "bytes";
          var filesize = value.size;
          if (filesize > 1024){
            filesize = filesize / 1024;
            sizeLabel = "kb";
            if(filesize > 1024){
              filesize = filesize / 1024;
              sizeLabel = "MB";
            }
          }
          imagePreview += '<div class="uppy-thumbnail-container" data-id="'+value.id+'">'+thumbnail+' <span class="uppy-thumbnail-label">'+value.name+' ('+ Math.round(filesize, 2) +' '+sizeLabel+')</span><span data-id="'+value.id+'" class="uppy-remove-thumbnail"><i class="flaticon2-cancel-music"></i></span></div>';

          console.log(value.response.body)
          insertImageSignedId(value.response.body.signedId)
        });

        $(id + ' .uppy-thumbnails').append(imagePreview);
      });

      const insertImageSignedId = (signed_id) => {
        console.log(signed_id)
        const hiddenField = document.createElement("input")
        hiddenField.setAttribute("type", "hidden")
        hiddenField.setAttribute("value", signed_id)
        hiddenField.name = field_name
        $('form').append(hiddenField)
      }

      $(document).on('click', id + ' .uppy-thumbnails .uppy-remove-thumbnail', function(){
        var imageId = $(this).attr('data-id');
        uppyDrag.removeFile(imageId);
        $(id + ' .uppy-thumbnail-container[data-id="'+imageId+'"').remove();
      });
    }

    function validateFormR(form){
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
    }

    initUploadDocument()

    $('#next-step').click(function(e){
      var validations = validateFormR(form);

      validations.validate().then(function (status) {
        if (status == 'Valid') {
          $(form).submit()
          KTUtil.scrollTop();
        } else {
          KTUtil.scrollTop();
        }
      });
    })

    $('input[type=radio]').change(function(){
      $('input[type=radio]').prop('checked', false)
      $(this).prop('checked', true)
    })
  }
})
