var call = false,
first = true,
timer = 60000;
callData = [];

$('#search-form').submit(function(event) {
	console.log('send');
	params = $(this).serializeArray();
	data = [];
	data.push(params[0]['value']);
	data.push(params[1]['value']);

	callData = ['search','GET',$.param({search: params[2]['value'],rows:JSON.stringify([data])})];
	if(first){
		ajaxCall();
		first = !first;
	}
});

$('#csv-form').submit(function(event) {
	event.preventDefault();
	var formData = new FormData();
	console.log('send')
	file = $(this).children('[type="file"]');
	search = $(this).serializeArray();
	file = file[0].files[0];
	formData.append('upload[dataFile]',file,file.name);
	formData.append('upload[search]',search[0].value);

	callData = ['upload','POST',formData];
	if(first){
		ajaxCall();
		first = !first;
	}
});

var ajaxCall = function(){
	console.log(callData);
	if(!call){
		call = true;
		$.ajax({
		url: '/api/v1/'+callData[0],
		type: callData[1],
		data: callData[2],
		processData: false,
		contentType: false
		})
		.done(function(data) {
			$('#tweets').html(data);
		})
		.always(function(){
			call = false;
			console.log('timeout');
		});
	}
	setTimeout(ajaxCall,timer);
}