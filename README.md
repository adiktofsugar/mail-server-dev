Mail server dev
---

smtp-server.js will listen for smtp messages and change the address to $USER@localhost, then send using sendmail
dovecot will be the mail server, serving from the /var/mail/$USER inbox (no matter what) and putting the other mboxes in ~/mail

## Installation
It's probably best to install this package globally rather than have it in a project, since there's no straightforward way I can see to cleanly install / uninstall for only one project, because of the nature of dovecot and plist files.

install.sh will run when you install the package. Runs the following:

- `brew install dovecot`
- installs dovecot configuration
- `sudo brew services dovecot start`, which will trigger a password request and make dovecot actually start running.
- creates a local plist for smtp-server.js to start running
- sends a test message

## Uninstallation
uninstall.sh will run when you uninstall the package. Runs the following:

- stops, unloads, and removes the plist for smtp-server.js
- dovecot remains installed and running. Use `brew uninstall dovecot` for a clean uninstall

## Connecting with Apple mail
Open up mail, add an account -> other (mail account), but in any username / email, and password "mail-server-dev", it'll fail, then put in IMAP hostname "127.0.0.1" in incoming and outgoing (you can't send mail), agree to send password insecurely, click next, and you should be done, and see a message that's welcoming you to mail-server-dev.

## FUTURE
Also, I'd rather make an actual user instead of using the current one....
I want to, instead of actually sending the mail with sendmail, to just write the file directly, in case a user was actually trying to send mail and has weird configuration settings for sendmail that would make this not work.

## Contributing
Make a pull request. This is more or less designed for me, but I put it in this module in case anyone else wanted similar functionality and likes node. /shrug
