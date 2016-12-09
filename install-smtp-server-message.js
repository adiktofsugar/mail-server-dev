#!/usr/bin/env node
var nodemailer = require('nodemailer');
var smtpTransport = require('nodemailer-smtp-transport');

var username = process.env.USER;
var transporter = nodemailer.createTransport(smtpTransport({
    port: 1025,
    secure: false,
    ignoreTLS: true,
    tls: {
        rejectUnauthorized: false
    }
}));

transporter.sendMail({
    from: 'anyone@there.com',
    to: 'adiktofsugar@gmail.com',
    subject: 'Welcome to mail-server-dev!',
    text: 'Here\'s looking at you, mail client!'
}, function (error, info) {
    if (error) {
        console.error(error);
        return process.exit(1);
    }
    console.log('Sent test message. Check your mailbox!');
});
