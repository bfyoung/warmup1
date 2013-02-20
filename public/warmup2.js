
  function initElement()
  {
  var lgnbutton = document.getElementById("login");
  lgnbutton.onclick = handleLoginClick;
  var addbtn = document.getElementById("adduser");
  addbtn.onclick = handleAddUserClick;
  }

  function handleErrorCode(errCode) {
  msgBox.html = get_message_for_errcode(errCode);
  }

//based on the example at http://stackoverflow.com/questions/11456771/using-json-post-request
  function handleLoginClick() {   
      var msgBox = document.getElementById("msgbox");   
  var username = document.getElementById('username').value;
  var pwd = document.getElementById('password').value;
  // get response code from /users/login
      $.ajax({
	  type: 'POST',
	  url:"/users/login", 
	  data: { user: username, password: pwd },
	  dataType: "json",
	  success: function(result) {
	      //process login
	      if ( result.errCode == 1) {
		  //display welcome page
		  msgBox.innerHTML = "Welcome "+username+"<br />"+"You have logged in "+result.count+" times."
		  var buttons = document.getElementById('buttons');
		  buttons.innerHTML = "<input type=\"button\" value=\"Logout\" onclick=\"history.go(-1)\">"
	      } else {
		  msgBox.innerHTML = getErrorMessage(result.errCode);
	      }
	  },
	  error: function(xhr, ajaxOptions, thrownError) { //error should not be thrown
	      alert("Unexpected error occurred.")
	      alert(xhr.status);
	      alert(thrownError);
	  }
      });
  }
  
function getErrorMessage(errCode) {
    switch (errCode) {
    case -1:
	return ("Invalid username and password combination. Please try again. ");
	break;
    case -2:
	return ("This user name already exists. Please try again.");
	break;
    case -3:
	return ("The user name should not be empty and at most 128 characters long. Please try again.");
	break;
    case -4:
        return ("The password should be at most 128 characters long. Please try again");
	break;
    default:
	return ("Unexpected error occurred.");
	break;	
    }
}

  function handleAddUserClick() {
      var msgBox = document.getElementById("msgbox");
      //alert("Handles!");
      //msgBox.innerHTML = "Hello javascript!";
      var username = document.getElementById('username').value;
      var pwd = document.getElementById('password').value;
      // get response code from /users/add
      $.ajax({
	  type: 'POST',
	  url:"/users/add", 
	  data: { user: username, password: pwd },
	  dataType: "json",
	  success: function(result) {
	      //process login
	      //alert("Result!");
	      if (result.errCode == 1) {
		  //display welcome page
		  msgBox.innerHTML = "Welcome "+username+"<br />"+"You have logged in "+result.count+" times."
		  var buttons = document.getElementById('buttons');
		  buttons.innerHTML = "<input type=\"button\" value=\"Logout\" onclick=\"history.go(-1)\">"
	      } else {
		  msgBox.innerHTML = getErrorMessage(result.errCode);
	      }
	      //msgBox.innerHTML = result;
	  },
	  error: function(xhr, ajaxOptions, thrownError) { //error should not be thrown
	      alert("Password"+pwd+"uname"+username);
	      alert(xhr.status);
	      alert(thrownError);
	  }
      });

  }

  function performAndReturnCode(action_type) {
}