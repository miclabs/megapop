$(document).ready(function(){
  const Tus = Uppy.Tus;
	const ProgressBar = Uppy.ProgressBar;
	const StatusBar = Uppy.StatusBar;
	const Informer = Uppy.Informer;

  var initUploadDocument = function(){
		var id = '#kt_uppy_3';

		var uppyDrag = Uppy.Core({
			autoProceed: true,
			restrictions: {
				maxFileSize: 1000000, // 1mb
				maxNumberOfFiles: 5,
				minNumberOfFiles: 1,
				allowedFileTypes: ['image/*', 'video/*']
			}
		});

		uppyDrag.use(Uppy.DragDrop, { target: id + ' .uppy-drag' });
		uppyDrag.use(ProgressBar, {
			target: id + ' .uppy-progress',
			hideUploadButton: false,
			hideAfterFinish: false
		});
		uppyDrag.use(Informer, { target: id + ' .uppy-informer'  });
		uppyDrag.use(Tus, { endpoint: 'payment_requests/upload' });

		uppyDrag.on('complete', function(file) {
			var imagePreview = "";
			$.each(file.successful, function(index, value){
				var imageType = /image/;
				var thumbnail = "";
				if (imageType.test(value.type)){
					thumbnail = '<div class="uppy-thumbnail"><img src="'+value.uploadURL+'"/></div>';
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
			});

			$(id + ' .uppy-thumbnails').append(imagePreview);
		});

    const insertImageSignedId = (form, input, signed_id) => {
      const hiddenField = document.createElement("input")
      hiddenField.setAttribute("type", "hidden")
      hiddenField.setAttribute("value", signed_id)
      hiddenField.name = 'files_1'
      form.appendChild(hiddenField)
    }

    uppyDrag.on("complete", result => {
      result.successful.forEach(file => {
        insertImageSignedId(file)
      })
    })

		$(document).on('click', id + ' .uppy-thumbnails .uppy-remove-thumbnail', function(){
			var imageId = $(this).attr('data-id');
			uppyDrag.removeFile(imageId);
			$(id + ' .uppy-thumbnail-container[data-id="'+imageId+'"').remove();
		});
	}

  initUploadDocument()
})
