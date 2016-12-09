var nodemailer = require('nodemailer');
var sendmailTransport = require('nodemailer-sendmail-transport');
var SMTPServer = require('smtp-server').SMTPServer;

// create reusable transporter object using sendmail transport
var transporter = nodemailer.createTransport(sendmailTransport());

var username = process.env.USER;
var server = new SMTPServer({
    authOptional: true,
    allowInsecureAuth: true,
    disableReverseLookup: true,
    logger: true,
    onData: function (stream, session, callback) {
        var envelope = session.envelope;
        envelope.to = username + '@localhost';

        // send mail with defined transport object
        transporter.sendMail({
            envelope: envelope,
            raw: stream
        }, function(error, info){
            if(error) console.error(error);
            callback();
        });
    }
});
server.listen(1025);
