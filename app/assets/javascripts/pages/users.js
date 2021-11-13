/******/ (() => { // webpackBootstrap
/******/ 	"use strict";
var __webpack_exports__ = {};
var KTAppsUsersListDatatable = function() {
	var _handleForm = function() {
		var form = KTUtil.getById('user-form');
		var action_class = document.getElementById('user-form').className;

		var validations;

		var edit_fields = {
			'user[first_name]': {
				validators: {
					notEmpty: {
						message: 'First name is required'
					}
				}
			},
			'user[last_name]': {
				validators: {
					notEmpty: {
						message: 'Last name is required'
					}
				}
			},
			'user[ssn]': {
				validators: {
					notEmpty: {
						message: 'SSN is required'
					}
				}
			},
			'user[postcode]': {
				validators: {
					notEmpty: {
						message: 'Postcode is required'
					}
				}
			},
			'user[email]': {
				validators: {
					notEmpty: {
						message: 'Email is required'
					},
					emailAddress: {
						message: 'The value is not a valid email address'
					}
				}
			},
			'user[phone_number]': {
				validators: {
					notEmpty: {
						message: 'Phone is required'
					}
				}
			},
			'user[street_address_1]': {
				validators: {
					notEmpty: {
						message: 'Address 1 is required'
					}
				}
			},
			'user[street_address_2]': {
				validators: {
					notEmpty: {
						message: 'Address 2 is required'
					}
				}
			},
			'user[city]': {
				validators: {
					notEmpty: {
						message: 'City is required'
					}
				}
			},
			'user[state]': {
				validators: {
					notEmpty: {
						message: 'State is required'
					}
				}
			},
			'user[zip_code]': {
				validators: {
					notEmpty: {
						message: 'Zipcode is required'
					}
				}
			}
		}

		var password_fields = {
			'user[password]': {
				validators: {
					notEmpty: {
						message: 'Password is required'
					},
					stringLength: {
							min: 6,
							message: 'Password is too short (minimum is 6 characters)',
					},
				}
			},
			'user[password_confirmation]': {
				validators: {
					notEmpty: {
						message: 'Password confirmation is required'
					},
					stringLength: {
							min: 6,
							message: 'Password is too short (minimum is 6 characters)',
					},
				}
			}
		}

		var new_fields = { ...edit_fields, ...password_fields }

		if (!form) {
			return;
		}

		if(action_class.includes('new_user')) {
			validations = FormValidation.formValidation(
				form, {
					fields: new_fields,
					plugins: {
						trigger: new FormValidation.plugins.Trigger(),
						bootstrap: new FormValidation.plugins.Bootstrap()
					}
				}
			);
		} else {
			validations = FormValidation.formValidation(
				form,
				{
					fields: edit_fields,
					plugins: {
						trigger: new FormValidation.plugins.Trigger(),
						bootstrap: new FormValidation.plugins.Bootstrap()
					}
				}
			);
		}
		// Validation before submit
		$('#kt_user_submit_button').click(function(e){
			e.preventDefault();
			validations.validate().then(function (status) {
				if (status == 'Valid') {

					form.submit()
					KTUtil.scrollTop();
				} else {
					KTUtil.scrollTop();
				}
			});
		});
	};

	return {
		// public functions
		init: function() {
			_handleForm();
		},
	};
}();

jQuery(document).ready(function() {
	if($('body.users').length) {
		KTAppsUsersListDatatable.init();
	}
});

/******/ })()
;
//# sourceMappingURL=list-datatable.js.map