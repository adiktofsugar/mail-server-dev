Mail server dev
---

smtp-server.js will listen for smtp messages and change the address to $USER@localhost, then send using sendmail
dovecot will be the mail server, serving from the /var/mail/$USER inbox (no matter what) and putting the other mboxes in ~/mail

## Installation
You have to run `./install.sh`, which will run `brew install dovecot`, then configure it so it only looks at the one mbox. It will also use `sudo brew services dovecot start`, which will trigger a password request and make dovecot actually start running.

## Connecting with Apple mail
Open up mail, add an account -> other (mail account), but in any username / email, and password "mail-server-dev", it'll fail, then put in IMAP hostname "127.0.0.1" in incoming and outgoing (you can't send mail), agree to send password insecurely, click next, and you should be done, and see a message that's welcoming you to mail-server-dev.

## FUTURE
Also, I'd rather make an actual user instead of using the current one....
I want to, instead of actually sending the mail with sendmail, to just write the file directly, in case a user was actually trying to send mail and has weird configuration settings for sendmail that would make this not work.

## Contributing
Make a pull request. This is more or less designed for me, but I put it in this module in case anyone else wanted similar functionality and likes node. /shrug
