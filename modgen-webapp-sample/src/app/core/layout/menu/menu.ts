import { Utils } from "src/app/utils/utils";

export interface DynamicMenu {
    name: string,
    url?: string,
    icon: string,
    permissions: string[],
    child?: DynamicMenu[];
}

export const initialNavigation: DynamicMenu[] = [
    {
        name: 'Event',
        icon: 'event_available',
        permissions: ['LIST_EVENT'],
        child: [
            {
                name: 'Event List',
                url: Utils.paths.EVENT.LIST,
                icon: 'list',
                permissions: ['LIST_EVENT'],
            },
            {
                name: 'New Event',
                url: Utils.paths.EVENT.NEW,
                icon: 'add',
                permissions: ['SAVE_EVENT'],
            },
        ]
    },
    {
        name: 'Venue',
        icon: 'business',
        permissions: ['LIST_VENUE'],
        child: [
            {
                name: 'Venue List',
                url: Utils.paths.VENUE.LIST,
                icon: 'list',
                permissions: ['LIST_VENUE'],
            },
            {
                name: 'New Venue',
                url: Utils.paths.VENUE.NEW,
                icon: 'add',
                permissions: ['SAVE_VENUE'],
            },
        ]
    },
    {
        name: 'Organizer',
        icon: 'person',
        permissions: ['LIST_ORGANIZER'],
        child: [
            {
                name: 'Organizer List',
                url: Utils.paths.ORGANIZER.LIST,
                icon: 'list',
                permissions: ['LIST_ORGANIZER'],
            },
            {
                name: 'New Organizer',
                url: Utils.paths.ORGANIZER.NEW,
                icon: 'add',
                permissions: ['SAVE_ORGANIZER'],
            },
        ]
    },

]
