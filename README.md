# Social-Login-Files-Only
You have to register your app to Facebook and twitter developer console. 
After that follow their step to install pods, and add keys and all in info.plist and app delegate.
I am just putting there code files to get user data from fb and twitter.

for google login you need to run google project, to integrate it into new one, must follow google steps also see project's info.plist file "

<key>CFBundleURLTypes</key>
	<array>
		<dict>
			<key>CFBundleTypeRole</key>
			<string>Editor</string>
			<key>CFBundleURLSchemes</key>
			<array>
				<string>com.googleusercontent.apps.393052251021-kb1niqn0v35q3932kumev5epc5trq4q3</string>
			</array>
		</dict>
		<dict>
			<key>CFBundleTypeRole</key>
			<string>Editor</string>
			<key>CFBundleURLSchemes</key>
			<array>
				<string>Nitin-Bhatia.GoogleLoginTest</string>
			</array>
		</dict>
	</array>
"

also copy plist file of google into your project plus above string  "com.googleusercontent.apps.393052251021-kb1niqn0v35q3932kumev5epc5trq4q3" and  "Nitin-Bhatia.GoogleLoginTest" both are need to be changed according to new project

Nitin-Bhatia.GoogleLoginTest is a bundle identifier of project....
