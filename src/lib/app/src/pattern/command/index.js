// Declare class
export default class Command {
    // Constructor
    constructor($name) {
        // private variable, not safe way.
        this.name = $name ? $name : this.constructor.name;
    }

    // execute
    // Execute algorithm in this object.
    async execute($args = null) {
        return $args;
    }
}
