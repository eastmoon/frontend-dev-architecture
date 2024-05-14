// Import pattern class
const singleton = require('./singleton').default;
const container = require('./container').default;
const command = require('./command').default;

// Output module
module.exports = {
    singleton,
    container,
    command,
};
