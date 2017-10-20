$(document).ready(function(){
	$('#nav-menu1').click(function(){
		$('#menu1').fadeIn('slow');
	});
	$('#nav-menu2').click(function(){
		$('#menu2').fadeIn('slow');
	});
	$('#nav-menu3').click(function(){
		$('#menu3').fadeIn('slow');
	});
});

function onSignIn(googleUser) {
  var profile = googleUser.getBasicProfile();
  console.log('ID: ' + profile.getId()); // Do not send to your backend! Use an ID token instead.
  console.log('Name: ' + profile.getName());
  console.log('Image URL: ' + profile.getImageUrl());
  console.log('Email: ' + profile.getEmail()); // This is null if the 'email' scope is not present.
}

  function signOut() {
    var auth2 = gapi.auth2.getAuthInstance();
    auth2.signOut().then(function () {
      console.log('User signed out.');
    });
  }