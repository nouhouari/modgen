import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';

export class UploadedFile{
  public fileName: string;
}

@Injectable({
  providedIn: 'root'
})
export class FileService {

  constructor(private http: HttpClient) {
    
  }

  /**
   * Upload a file to backend
   * @param file file to upload
   * @returns FileUpload observable
   */
  public uploadFile(file: File): Observable<UploadedFile>{
    const formData = new FormData();
    formData.append("file", file);
    return this.http.post<UploadedFile>('api/file', formData);
  }

  /**
   * Construct file url from filename
   * @param fileName File name
   * @returns full file url
   */
  public getFileUrl(fileName: String){
    return 'api/file?fileName=${fileName}';
  }
}