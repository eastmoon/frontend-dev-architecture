// Import library
import clibs from 'clibs';
import AppService from '../services/app';

// Declare variable
const Command = clibs.pattern.command;
const Application = clibs.application;
const Utils = clibs.utils;

// Declare class
export default class StartupCommand extends Command {
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
