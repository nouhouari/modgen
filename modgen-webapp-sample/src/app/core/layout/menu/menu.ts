import { Utils } from "src/app/utils/utils";

export interface DynamicMenu {
    name: string,
    url?: string,
    icon: '',
    permissions: string[],
    child?: DynamicMenu[];
}

export const initialNavigation: DynamicMenu[] = [
    {
        name: 'Event',
        icon: '',
        permissions: ['LIST_EVENT'],
        child: [
            {
                name: 'Event List',
                url: Utils.paths.EVENT.LIST,
                icon: '',
                permissions: ['LIST_EVENT'],
            },
            {
                name: 'New Event',
                url: Utils.paths.EVENT.NEW,
                icon: '',
                permissions: ['SAVE_EVENT'],
            },
        ]
    },

]
