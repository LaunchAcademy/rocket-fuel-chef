on run argv
	tell application "Safari"
		activate

		set apple_id to the text returned of (display dialog "Rocket Fuel: please enter your AppleID email:" with title "Apple ID" default answer "" buttons {"OK"} default button 1)
		set apple_password to the text returned of (display dialog "Rocket Fuel: please enter your AppleID password:" with title "Password" with icon caution default answer "" buttons {"OK"} default button 1 with hidden answer)

		open location "https://developer.apple.com/downloads/index.action"
		delay 3 -- this is a delay to allow the page to start loading
		--wait till it's loaded
		set pageLoaded to false -- this initialises the pageLoaded variable that gets set below
		repeat while not pageLoaded -- keep doing this loop until loading complete
			if (do JavaScript "document.readyState" in current tab of window 1) is "complete" then
				set pageLoaded to true
			else
				delay 3 -- you can try adjusting this delay
			end if
		end repeat
		delay 3
		do JavaScript "
			function fillInForm(){
				//https://developer.apple.com/downloads/index.action
				if(jQuery('#accountname').length > 0){
					jQuery('#accountname').val('" & apple_id & "');
					jQuery('#accountpassword').prop('type', 'hidden');
					jQuery('#accountpassword').val('" & apple_password & "');
					jQuery('#accountname').parents('form')[0].submit();
				}
			}


			//script courtesy of http://remysharp.com/2007/04/12/how-to-detect-when-an-external-library-has-loaded/
			function loadExtScript(src, test, callback) {
				var s = document.createElement('script');
				s.src = src;
				document.body.appendChild(s);

				var callbackTimer = setInterval(function() {
					var call = false;
					try {
						call = test.call();
					} catch (e) {}

					if (call) {
						clearInterval(callbackTimer);
						callback.call();
					}
				}, 100);
			}

			loadExtScript('https://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js',
				function(){ return typeof jQuery == 'function'},
				fillInForm);
		" in current tab of window 1
		open location item 1 of argv
		display dialog "Download initiated...navigate back to your terminal and await completion"
	end tell
end run
