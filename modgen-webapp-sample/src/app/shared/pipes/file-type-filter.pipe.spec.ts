import { FileTypeFilterPipe } from './file-type-filter.pipe';

describe('ImageFilterPipe', () => {
  it('create an instance', () => {
    const pipe = new FileTypeFilterPipe();
    expect(pipe).toBeTruthy();
  });
});
