/*
    Container, focus on object manager.
    use it to register, retrieve, remove, check Object.

    author: jacky.chen
*/

// Container class
export default class Container {
    constructor() {
        // declared member variable
        this.container = {};
    }

    // Register,
    register($name, $obj) {
        // 1. check model is duplicate or not
        if (typeof $obj !== "undefined" &&
            typeof $name !== "undefined" &&
            (typeof this.container[$name] === "undefined" || this.container[$name] === null)
        ) {
            // 2. saving non-duplicate model.
            this.container[$name] = $obj;
        } else {
            // 3. throw error message for duplicate register.
            return false;
        }
        return true;
    }

    // Remove,
    remove($name) {
        // 1. retrieve model, if exist, remove it.
        const obj = this.retrieve($name);
        if (obj !== null) {
            // remove target object in mapping.
            this.container[$name] = null;
        }
        // return target object.
        return obj;
    }

    // Retrieve,
    retrieve($name) {
        // using mapping to check, if exist return object, then return null
        if (this.has($name)) {
            return this.container[$name];
        }
        return null;
    }

    // Check,
    has($name) {
        // retireve object, if null then dosn't exist.
        if (typeof this.container[$name] === "undefined" || this.container[$name] === null) {
            return false;
        }
        return true;
    }
}
