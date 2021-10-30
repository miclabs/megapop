/******/ (() => { // webpackBootstrap
/******/ 	"use strict";
var __webpack_exports__ = {};
/*!***********************************************************!*\
  !*** ../demo3/src/js/pages/custom/user/list-datatable.js ***!
  \***********************************************************/

// Class definition

var KTAppsUsersListDatatable = function() {
	// Private functions

	// basic demo
	var _demo = function() {
		$('#kt_datatable').DataTable({
			responsive: true,
			paging: true
		});
		// var datatable = $('#kt_datatable').KTDatatable({
		// 	// datasource definition
		// 	data: {
		// 		type: 'local',
		// 		// source: {
		// 		// 	read: {
		// 		// 		url: 'https://preview.keenthemes.com/keen/theme/tools/preview' + '/api/datatables/demos/default.php',
		// 		// 	},
		// 		// },
		// 		pageSize: 10, // display 20 records per page
		// 		// serverPaging: true,
		// 		// serverFiltering: true,
		// 		// serverSorting: true,
		// 	},

		// 	// layout definition
		// 	layout: {
		// 		scroll: false, // enable/disable datatable scroll both horizontal and vertical when needed.
		// 		footer: false, // display/hide footer
		// 	},

		// 	// column sorting
		// 	sortable: true,

		// 	pagination: true,

		// 	search: true
		// });

		// $('#kt_datatable_search_status').on('change', function() {
		// 	datatable.search($(this).val().toLowerCase(), 'Status');
		// });

		// $('#kt_datatable_search_type').on('change', function() {
		// 	datatable.search($(this).val().toLowerCase(), 'Type');
		// });

		// $('#kt_datatable_search_status, #kt_datatable_search_type').selectpicker();
	};

	return {
		// public functions
		init: function() {
			_demo();
		},
	};
}();

jQuery(document).ready(function() {
	KTAppsUsersListDatatable.init();
});

/******/ })()
;
//# sourceMappingURL=list-datatable.js.map