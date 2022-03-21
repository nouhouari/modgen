import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'fileTypeFilter'
})
export class FileTypeFilterPipe implements PipeTransform {

  transform(value: File[], args: string): any {
    console.log('Enter pipe with ', value, args);
    
    
    if (!value) return null;
    if (!args) return value;

    return value.filter(f => {
      console.log(f);
      console.log(f.type.startsWith(args));
      return f.type.startsWith(args);
    })
  }

}
