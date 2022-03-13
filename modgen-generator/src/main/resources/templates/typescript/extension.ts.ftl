import { Item, FieldValues, Schema } from 'hin-extension-schema';

/**
 * Extension values.
 */
export class Extensions extends Item {

  constructor(public values: FieldValues, public schema: Schema) {
    super(values, schema);
  }
}
