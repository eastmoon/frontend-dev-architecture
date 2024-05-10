'use strict';

function echoi(msg) {
    console.log(`%c ${msg}`, 'color: chartreuse; font-size: 12px');
}

function echow(msg) {
    console.log(`%c ${msg}`, 'color: lightyellow; font-size: 12px');
}

function echoe(msg) {
    console.log(`%c ${msg}`, 'color: red; font-size: 12px');
}

module.exports = {
    echoi,
    echow,
    echoe,
};
