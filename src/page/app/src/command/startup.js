// Import library
import {Application, Utils, Pattern} from 'clibs';
import AppService from '../services/app';

// Declare variable

// Declare class
export default class StartupCommand extends Pattern.Command {
    //
    constructor() {
        super("StartupCommand");
    }
    //
    async execute() {
        const app = new Application();
        console.log(app);
        Utils.echoi(Application.appName);
        console.log(Application.views);
        console.log(Application.controllers);
        console.log(Application.models);
        Application.models.register(AppService.Name, new AppService());
    }
}
