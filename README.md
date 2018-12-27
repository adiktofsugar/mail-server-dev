Mail server dev
---

Goal is basically this: http://mocksmtpapp.com/
...except in node, and free, and generally not as good, hehe.

## Overview of email

To send an email, you send a message to a mail transfer agent (MTA). This is generally configurable in your app framework, like rails, django, etc. The MTA sends the message via SMTP to the destination address. The destination SHOULD have an MTA running that will handle receiving the mail. The destination MTA can save it in whatever way it wants, but it's usually an mbox (which is a special format for email) or a database. To look at your email, you usually use a POP server or an IMAP server, which connects to the destination MTA to pull in the data stored in the mbox / db. Your mail client (outlook, thunderbird, etc) connects to the POP / IMAP server and displays the data in a more presentable way.

## Overview of package

This package is really just the SMTP server. You should configure your app to use this smtp server, so when you send email it'll always go to this one. When you do, it'll change the destination to `$USER@localhost` and send the message. So now you're sending an email to yourself on your computer, which means it's sent to your computers local MTA (through sendmail, which also uses smtp). On Mac, postfix (an MTA) is already installed, and it stores the messages in /var/mail/$USER.
Dovecot is the IMAP server that pulls the messages out of /var/mail/$USER and stores them in /Users/$USER/.mail-server-dev/mboxes.

## Installation

- `git clone` this repo
- run `npm install`

### Full installation

- run `./install.sh`

This assumes you have brew, git, and node / npm installed, and does this:

- `brew install dovecot`
- installs dovecot configuration
- `sudo brew services dovecot start`, which will trigger a password request and make dovecot actually start running.
- creates a local plist for smtp-server.js to start running
- sends a test message

### Just smtp server

- run `npm start`

This only starts the SMTP server. So you can point to this server and it will use sendmail to send it to you, but then it's up to you to look at the mail.


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
